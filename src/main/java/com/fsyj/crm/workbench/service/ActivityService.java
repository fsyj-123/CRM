package com.fsyj.crm.workbench.service;

import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.workbench.bean.Activity;

import java.util.Map;

public interface ActivityService {
    void saveActivity(Activity activity) throws Exception;

    PageNavigate<Activity> getPageList(Map<String, Object> parameterMap);
}
