package com.fsyj.crm.settings.service;

import com.fsyj.crm.settings.bean.User;


import javax.security.auth.login.LoginException;
import java.util.List;

public interface UserService {
    User login(String loginAct, String loginPwd, String IP) throws LoginException;

    List<User> getUserList();


}
