package com.fsyj.crm.settings.web.controller;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.PrintJson;
import com.fsyj.crm.utils.ServiceFactory;
import com.fsyj.crm.web.controller.BaseServlet;

import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

public class UserServlet extends BaseServlet {
    private UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());

    public void login(HttpServletRequest request, HttpServletResponse response) {
        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        String remoteIP = request.getRemoteAddr();
        try {
            User user = userService.login(loginAct, loginPwd, remoteIP);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            PrintJson.printJsonFlag(response, true);
        } catch (LoginException e) {
            // 捕获到异常，说明用户登陆失败
            e.printStackTrace();
            Map<String, Object> map = new HashMap<>();
            map.put("success", false);
            map.put("msg", e.getMessage());
            PrintJson.printJsonObj(response, map);
        }
    }
}
