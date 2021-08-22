package com.fsyj.crm.workbench.service;

import com.fsyj.crm.workbench.bean.Customer;

import java.util.List;

/**
 * @author fsyj
 */
public interface CustomerService {

    /**
     * 根据name模糊查询
     * @param name
     * @return
     */
    List<Customer> fuzzySearch(String name);
}
