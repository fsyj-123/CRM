package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.ContactsActivityRelation;

/**
 * @author fsyj
 */
public interface ContactsActivityRelationMapper {


    /**
     * 添加联系人市场活动关联表
     * @param contactsActivityRelation
     */
    void save(ContactsActivityRelation contactsActivityRelation);
}
