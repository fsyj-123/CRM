package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.ClueActivityRelation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    /**
     * 根据线索ID查询备注
     * @param clueId
     * @return
     */
    List<ClueActivityRelation> queryByClueId(@Param("clueId") String clueId);


    /**
     * 通过ID删除
     * @param id
     */
    void deleteById(@Param("id") String id);
}
