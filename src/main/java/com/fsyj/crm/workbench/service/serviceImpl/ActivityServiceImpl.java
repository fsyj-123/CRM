package com.fsyj.crm.workbench.service.serviceImpl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.mapper.ActivityMapper;
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
}
