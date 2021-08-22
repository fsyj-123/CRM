package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.TranHistory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author fsyj
 */
public interface TranHistoryMapper {

    /**
     * save
     * @param tranHistory
     */
    void save(TranHistory tranHistory);

    /**
     * 通过tranId查
     * @param tranId
     * @return
     */
    List<TranHistory> queryByTranId(@Param("tranId") String tranId);
}
