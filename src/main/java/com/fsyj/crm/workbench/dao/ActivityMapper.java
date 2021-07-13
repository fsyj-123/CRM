package com.fsyj.crm.workbench.dao;

import com.fsyj.crm.workbench.bean.Activity;
import org.apache.ibatis.annotations.Param;

public interface ActivityMapper {
    public int saveActivity(Activity activity);
}
