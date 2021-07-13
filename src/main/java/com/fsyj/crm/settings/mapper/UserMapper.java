package com.fsyj.crm.settings.mapper;

import com.fsyj.crm.settings.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserMapper {
    User queryUser(@Param("loginAct") String loginAct, @Param("loginPwd") String loginPwd);

    List<User> queryAllUser();
}
