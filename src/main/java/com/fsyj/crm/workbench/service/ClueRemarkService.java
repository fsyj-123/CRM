package com.fsyj.crm.workbench.service;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.workbench.bean.ActivityRemark;

import java.util.List;

/**
 * @author fsyj
 */
public interface ClueRemarkService {

    /**
     * 根据ID展现线索备注
     * @param id
     * @return
     */
    List<ActivityRemark> getRemarkList(String id);

    /**
     * 添加备注
     * @param content
     * @param user
     * @param clueId
     */
    void addRemark(String content, User user, String clueId);
}
