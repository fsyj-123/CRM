package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.Customer;
import com.fsyj.crm.workbench.mapper.CustomerMapper;
import com.fsyj.crm.workbench.service.CustomerService;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * @author fsyj
 */
public class CustomerServiceImpl implements CustomerService {
    @Override
    public List<String> fuzzySearch(String name) {
        CustomerMapper customerMapper = SqlSessionUtil.getSqlSession().getMapper(CustomerMapper.class);
        List<Customer> customerList = customerMapper.fuzzyQuery(name);
        Iterator<Customer> iterator = customerList.iterator();
        ArrayList<String> nameList = new ArrayList<>(customerList.size());
        while (iterator.hasNext()) {
            nameList.add(iterator.next().getName());
        }
        return nameList;
    }
}
