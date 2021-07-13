package com.fsyj.crm.workbench.service.serviceImpl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.dao.ActivityMapper;
import com.fsyj.crm.workbench.service.ActivityService;

public class ActivityServiceImpl implements ActivityService {
    @Override
    public void saveActivity(Activity activity) throws Exception {
        ActivityMapper mapper = SqlSessionUtil.getSqlSession().getMapper(ActivityMapper.class);
        int count = mapper.saveActivity(activity);
        if (count != 1) {
            throw new Exception("保存失败");
        }
    }
}
