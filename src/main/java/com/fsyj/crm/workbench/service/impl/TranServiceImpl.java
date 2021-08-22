package com.fsyj.crm.workbench.service.impl;

import com.fsyj.crm.utils.BeanUtil;
import com.fsyj.crm.utils.SqlSessionUtil;
import com.fsyj.crm.workbench.bean.Customer;
import com.fsyj.crm.workbench.bean.Tran;
import com.fsyj.crm.workbench.bean.TranHistory;
import com.fsyj.crm.workbench.mapper.CustomerMapper;
import com.fsyj.crm.workbench.mapper.TranHistoryMapper;
import com.fsyj.crm.workbench.mapper.TranMapper;
import com.fsyj.crm.workbench.service.TranService;

/**
 * @author fsyj
 */
public class TranServiceImpl implements TranService {
    @Override
    public void save(Tran tran, String customerName) {
        TranMapper tranMapper = SqlSessionUtil.getSqlSession().getMapper(TranMapper.class);
        TranHistoryMapper tranHistoryMapper = SqlSessionUtil.getSqlSession().getMapper(TranHistoryMapper.class);
        CustomerMapper customerMapper = SqlSessionUtil.getSqlSession().getMapper(CustomerMapper.class);
        // 通过customerName查询customer，如果有则直接使用，否则创建新customer
        Customer customer = customerMapper.queryByName(customerName);
        if (customer == null) {
            customer = BeanUtil.createObject(Customer.class, tran.getCreateBy());
            BeanUtil.convert(customer, tran);
            customerMapper.createCustom(customer);
        }
        // 完善tran中的customerId
        tran.setCustomerId(customer.getId());
        // 保存交易以及交易历史
        tranMapper.save(tran);
        TranHistory history = BeanUtil.createObject(TranHistory.class, tran.getCreateBy());
        BeanUtil.convert(history, tran);
        history.setTranId(tran.getId());
        tranHistoryMapper.save(history);
    }
}
