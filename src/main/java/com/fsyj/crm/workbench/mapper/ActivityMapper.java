package com.fsyj.crm.workbench.mapper;

import com.fsyj.crm.workbench.bean.Activity;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author fsyj
 */
public interface ActivityMapper {
    public int saveActivity(Activity activity);

    Integer queryCountByCondition(Map<String, Object> map);

    List<Activity> queryListByCondition(Map<String, Object> map);

    void deleteByIds(@Param("ids") String[] ids);

    Activity queryById(@Param("id") String id);

    void updateById(@Param("id") String id, @Param("activity") Activity activity);

    Activity queryActivityById(@Param("id") String id);

    /**
     * 根据条件模糊查询
     *
     * @param text condition
     * @param clueId
     * @return
     */
    List<Activity> fuzzyQuery(@Param("condition") String text, @Param("clueId") String clueId);
}
