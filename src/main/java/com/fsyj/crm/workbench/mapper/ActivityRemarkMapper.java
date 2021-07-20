package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.ActivityRemark;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author fsyj
 */
public interface ActivityRemarkMapper {
    int queryCountByActivityId(@Param("id") String id);

    void deleteByAcId(@Param("id") String id);

    int queryCotInIds(@Param("ids") String[] ids);

    int deleteByAcIds(@Param("ids") String[] ids);

    List<ActivityRemark> queryByActivityId(@Param("id") String id);

    void deleteById(@Param("id") String id);

    void updateById(@Param("id") String id, @Param("content") String content, @Param("editor") String editor, @Param("editTime") String editTime);

    void inseartMark(@Param("remark") ActivityRemark activityRemark);
}
