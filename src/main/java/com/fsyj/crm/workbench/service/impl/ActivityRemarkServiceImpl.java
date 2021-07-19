package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.ActivityRemark;
import com.fsyj.crm.workbench.mapper.ActivityRemarkMapper;
import com.fsyj.crm.workbench.service.ActivityRemarkService;

import java.util.List;

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
}
