package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Tran;

public interface TranMapper {

    /**
     * 添加交易
     * @param tran
     */
    void save(Tran tran);
}
