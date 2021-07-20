package com.fsyj.crm.workbench.service;

import com.fsyj.crm.workbench.bean.ActivityRemark;

import java.util.List;

/**
 * @author fsyj
 */
public interface ActivityRemarkService {
    List<ActivityRemark> getRemarkList(String id);

    void deleteRemark(String id);

    void updateRemark(String id, String content, String editor);
}
