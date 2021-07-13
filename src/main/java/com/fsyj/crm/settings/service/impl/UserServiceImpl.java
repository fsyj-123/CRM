package com.fsyj.crm.settings.service.impl;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.mapper.UserMapper;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.utils.DateTimeUtil;
import com.fsyj.crm.utils.MD5Util;
import com.fsyj.crm.utils.SqlSessionUtil;

import javax.security.auth.login.LoginException;
import java.util.List;

public class UserServiceImpl implements UserService {


    @Override
    public User login(String loginAct, String loginPwd, String IP) throws LoginException {
        UserMapper mapper = SqlSessionUtil.getSqlSession().getMapper(UserMapper.class);
        loginPwd = MD5Util.getMD5(loginPwd);
        User user = mapper.queryUser(loginAct, loginPwd);
        if (user == null) {
            throw new LoginException("账号或密码错误");
        }
        // 验证登陆时间
        String expireTime = user.getExpireTime();
        String sysTime = DateTimeUtil.getSysTime();
        if (expireTime == null || sysTime.compareTo(expireTime) > 0) {
            throw new LoginException("登陆失效");
        }
        // 验证lockState
        if ("0".equals(user.getLockState())) {
            throw new LoginException("账户已锁定");
        }
        // 验证IP地址
        if (!user.getAllowIps().contains(IP)) {
            throw new LoginException("此IP禁止访问");
        }
        return user;
    }

    @Override
    public List<User> getUserList() {
        UserMapper mapper = SqlSessionUtil.getSqlSession().getMapper(UserMapper.class);
        return mapper.queryAllUser();
    }


}
