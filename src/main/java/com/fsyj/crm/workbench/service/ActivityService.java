package com.fsyj.crm.workbench.service;

import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.workbench.bean.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    void saveActivity(Activity activity) throws Exception;

    PageNavigate<Activity> getPageList(Map<String, Object> parameterMap);

    void deleteActivity(String[] ids) throws Exception;

    Activity getActivity(String id);

    void updateActivity(Activity activity);

    Activity getDetailByID(String id);

    /**
     * 通过条件模糊查询
     * @param text condition
     * @param clueId
     * @return list
     */
    List<Activity> getActivityByCondition(String text, String clueId);
}
