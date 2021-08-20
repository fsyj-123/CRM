package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Contacts;
import org.apache.ibatis.annotations.Param;

/**
 * @author fsyj
 */
public interface ContactsMapper {

    /**
     * Query by fullName
     * @param fullName
     * @return
     */
    Contacts queryByFullName(@Param("fullName") String fullName);

    /**
     * create
     * @param contacts
     */
    void create(Contacts contacts);
}
