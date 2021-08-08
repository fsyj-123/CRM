package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.ClueActivityRelation;

/**
 * @author fsyj
 */
public interface ClueActivityRelationMapper {


    /**
     * 绑定市场活动
     * @param relation
     * @return
     */
    int bind(ClueActivityRelation relation);
}
