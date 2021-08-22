package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Tran;
import org.apache.ibatis.annotations.Param;

public interface TranMapper {

    /**
     * 添加交易
     * @param tran
     */
    void save(Tran tran);

    /**
     * 通过ID查询tran
     * @param id
     * @return
     */
    Tran queryById(@Param("id") String id);
}
