package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.ActivityRemark;
import com.fsyj.crm.workbench.bean.ClueRemark;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author fsyj
 */
public interface ClueRemarkMapper {

    /**
     * 列表展示
     * @param id
     * @return
     */
    List<ActivityRemark> listById(@Param("id") String id);

    /**
     * 添加remark
     * @param remark
     */
    void addRemark(ClueRemark remark);

    /**
     * 通过clueId查询备注列表
     * @param clueId
     * @return
     */
    List<ClueRemark> queryById(@Param("clueId") String clueId);

    /**
     * 通过RemarkID删除备注
     * @param id
     */
    void deleteRemarkById(@Param("id") String id);
}
