package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.bean.Clue;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author fsyj
 */
public interface ClueMapper {

    /**
     * 保存线索
     *
     * @param clue 线索
     */
    void save(@Param("clue") Clue clue);

    /**
     * 查询所有数据
     *
     * @return clueList
     */
    List<Clue> queryAll();

    /**
     * 根据ID查单条记录
     *
     * @param id
     * @return
     */
    Clue queryForOne(@Param("id") String id);

    /**
     * 获取关联的市场活动
     *
     * @param clueId
     * @return
     */
    List<Activity> getRelatedActivity(@Param("clueId") String clueId);

    /**
     * 移除线索-活动关联关系
     *
     * @param relationId
     */
    void deleteRelation(@Param("relationId") String relationId);
}
