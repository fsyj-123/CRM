package com.fsyj.crm.workbench.mapper;

import org.apache.ibatis.annotations.Param;

public interface ActivityRemarkMapper {
    int queryCountByActivityId(@Param("id") String id);

    void deleteByAcId(@Param("id") String id);

    int queryCotInIds(@Param("ids") String[] ids);

    int deleteByAcIds(@Param("ids") String[] ids);
}
