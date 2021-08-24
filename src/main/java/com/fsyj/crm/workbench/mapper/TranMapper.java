package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.vo.EchartsDataPair;
import com.fsyj.crm.workbench.bean.Tran;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    /**
     * 通过ID更新阶段
     * @param tran
     */
    void updateStage(Tran tran);

    /**
     * 获取阶段数量分组数据
     * @return
     */
    List<EchartsDataPair> getStageGroup();
}
