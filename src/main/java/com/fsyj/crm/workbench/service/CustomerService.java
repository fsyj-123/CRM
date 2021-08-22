package com.fsyj.crm.workbench.service;

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
    List<String> fuzzySearch(String name);
}
