package com.fsyj.crm.workbench.service;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.bean.ActivityRemark;
import com.fsyj.crm.workbench.bean.Clue;
import com.fsyj.crm.workbench.bean.Tran;

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
    PageNavigate<Clue> getPageList(Integer pageNo, Integer pageSize);

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

    /**
     * 绑定市场活动
     * @param activityIds
     * @param clueId
     * @throws Exception
     */
    void bindActivity(String[] activityIds, String clueId) throws Exception;

    /**
     * 转换线索
     * @param clueId clueId必须
     * @param tran 为空说明不需要创建新交易
     * @param creator 创建者
     * @return flag
     */
    boolean convert(String clueId, Tran tran, User creator);


}
