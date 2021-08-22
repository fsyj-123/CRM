package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.Customer;
import com.fsyj.crm.workbench.mapper.CustomerMapper;
import com.fsyj.crm.workbench.service.CustomerService;

import java.util.List;

/**
 * @author fsyj
 */
public class CustomerServiceImpl implements CustomerService {
    @Override
    public List<Customer> fuzzySearch(String name) {
        CustomerMapper customerMapper = SqlSessionUtil.getSqlSession().getMapper(CustomerMapper.class);
        return customerMapper.fuzzyQuery(name);
    }
}
