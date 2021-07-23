package com.fsyj.crm.workbench.service;

import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.bean.Clue;

import java.util.List;

/**
 * @author fsyj
 */
public interface ClueService {
    /**
     * 保存线索
     *
     * @param clue 线索
     */
    void saveClue(Clue clue);

    /**
     * 分页查询线索
     *
     * @param pageNo
     * @param pageSize
     * @return List
     */
    List<Clue> getPageList(Integer pageNo, Integer pageSize);

    /**
     * 根据Id查Clue
     *
     * @param id
     * @return
     */
    Clue queryClueById(String id);

    /**
     * 获取关联的市场活动
     *
     * @param clueId
     * @return
     */
    List<Activity> getRelation(String clueId);

    /**
     * 移除线索-活动关联关系
     *
     * @param relationId
     */
    void removeRelation(String relationId);
}
