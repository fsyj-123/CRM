package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Clue;
import org.apache.ibatis.annotations.Param;

/**
 * @author fsyj
 */
public interface ClueMapper {

    /**
     * 保存线索
     * @param clue 线索
     */
    void save(@Param("clue") Clue clue);
}
