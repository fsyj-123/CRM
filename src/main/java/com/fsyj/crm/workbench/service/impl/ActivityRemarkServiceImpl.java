package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.DateTimeUtil;
import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.ActivityRemark;
import com.fsyj.crm.workbench.mapper.ActivityMapper;
import com.fsyj.crm.workbench.mapper.ActivityRemarkMapper;
import com.fsyj.crm.workbench.service.ActivityRemarkService;

import java.util.List;
import java.util.UUID;

/**
 * @author fsyj
 */
public class ActivityRemarkServiceImpl implements ActivityRemarkService {
    @Override
    public List<ActivityRemark> getRemarkList(String id) {
        ActivityRemarkMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkMapper.class);
        assert id != null && !"".equals(id);
        return mapper.queryByActivityId(id);
    }

    @Override
    public void deleteRemark(String id) {
        ActivityRemarkMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkMapper.class);
        assert id != null && !"".equals(id);
        mapper.deleteById(id);
    }

    @Override
    public void updateRemark(String id, String content, String editor) {
        ActivityRemarkMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkMapper.class);
        assert id != null && !"".equals(id);
        System.out.println(id);
        mapper.updateById(id, content, editor, DateTimeUtil.getSysTime());
    }

    @Override
    public void createRemark(ActivityRemark activityRemark) throws Exception {
        ActivityRemarkMapper remarkMapper = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkMapper.class);
        ActivityMapper activityMapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        if (activityMapper.queryById(activityRemark.getActivityId()) == null) {
            throw new Exception("活动不存在");
        }
        remarkMapper.inseartMark(activityRemark);
    }

}
