package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityMapper {
    public int saveActivity(Activity activity);

    Integer queryCountByCondition(Map<String, Object> map);

    List<Activity> queryListByCondition(Map<String, Object> map);
}
