package com.fsyj.crm.workbench.web.controller;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.PrintJson;
import com.fsyj.crm.utils.ServiceFactory;
import com.fsyj.crm.web.controller.BaseServlet;
import com.fsyj.crm.workbench.service.CustomerService;
import com.fsyj.crm.workbench.service.impl.CustomerServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * @author fsyj
 */
public class TranServlet extends BaseServlet {
    public void toSavePage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取用户信息列表，封装到request域中，请求转发
        UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> userList = userService.getUserList();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("/workbench/transaction/save.jsp").forward(request, response);
    }

    public void queryCustomByName(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        CustomerService customerService = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        List<String> nameList = customerService.fuzzySearch(name);
        PrintJson.printJsonObj(response, nameList);
    }
}
