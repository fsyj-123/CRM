package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.mapper.ActivityMapper;
import com.fsyj.crm.workbench.mapper.ActivityRemarkMapper;
import com.fsyj.crm.workbench.service.ActivityService;

import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {
    @Override
    public void saveActivity(Activity activity) throws Exception {
        ActivityMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        int count = mapper.saveActivity(activity);
        if (count != 1) {
            throw new Exception("保存失败");
        }
    }

    @Override
    public PageNavigate<Activity> getPageList(Map<String, Object> map) {
        ActivityMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        Integer totalCount = mapper.queryCountByCondition(map);
        List<Activity> pageList = mapper.queryListByCondition(map);
        PageNavigate<Activity> navigate = new PageNavigate<>();
        navigate.setTotal(totalCount);
        navigate.setPageList(pageList);
        return navigate;
    }

    @Override
    public void deleteActivity(String[] ids) throws Exception {
        ActivityMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        ActivityRemarkMapper remarkMapper = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkMapper.class);
        // 遍历每个id，寻找并删除这个市场活动id对应的备注，如果有则删除
        int count = remarkMapper.queryCotInIds(ids);
        int deleteCot = remarkMapper.deleteByAcIds(ids);
        if (count != deleteCot) {
            throw new Exception("市场活动备注删除失败");
        }
        mapper.deleteByIds(ids);
    }

    @Override
    public Activity getActivity(String id) {
        ActivityMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        assert id != null && !"".equals(id);
        return mapper.queryById(id);
    }

    @Override
    public void updateActivity(Activity activity) {
        ActivityMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        mapper.updateById(activity.getId(), activity);
    }

    @Override
    public Activity getDetailByID(String id) {
        ActivityMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        assert id != null && !"".equals(id);
        return mapper.queryActivityById(id);
    }
}
