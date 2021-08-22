package com.fsyj.crm.workbench.service;

import com.fsyj.crm.workbench.bean.Tran;

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
}
