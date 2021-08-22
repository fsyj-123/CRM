package com.fsyj.crm.workbench.service;

import com.fsyj.crm.workbench.bean.Tran;
import com.fsyj.crm.workbench.bean.TranHistory;

import java.util.List;

/**
 * @author fsyj
 */
public interface TranService {
    /**
     * 保存交易
     * @param tran
     * @param customerName
     */
    void save(Tran tran, String customerName);

    /**
     * 通过ID查单条记录
     * @param id
     * @return
     */
    Tran query(String id);

    /**
     * 查询交易历史
     * @param tranId
     * @return
     */
    List<TranHistory> getHistoryList(String tranId);
}
