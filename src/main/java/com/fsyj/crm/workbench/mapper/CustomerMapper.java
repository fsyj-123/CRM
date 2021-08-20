package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Customer;
import org.apache.ibatis.annotations.Param;

/**
 * @author fsyj
 */
public interface CustomerMapper {

    /**
     * 通过customName查询
     * @param company
     * @return
     */
    Customer queryByName(@Param("company") String company);

    /**
     * create
     * @param customer
     */
    void createCustom(Customer customer);
}
