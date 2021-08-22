package com.fsyj.crm.workbench.web.controller;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.*;
import com.fsyj.crm.utils.constStrings.Path;
import com.fsyj.crm.web.controller.BaseServlet;
import com.fsyj.crm.workbench.bean.Customer;
import com.fsyj.crm.workbench.bean.Tran;
import com.fsyj.crm.workbench.service.CustomerService;
import com.fsyj.crm.workbench.service.TranService;
import com.fsyj.crm.workbench.service.impl.CustomerServiceImpl;
import com.fsyj.crm.workbench.service.impl.TranServiceImpl;
import sun.plugin.util.UIUtil;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
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
        List<Customer> customers = customerService.fuzzySearch(name);
        List<String> nameList = new ArrayList<>(customers.size());
        for (Customer customer : customers) {
            nameList.add(customer.getName());
        }
        PrintJson.printJsonObj(response, nameList);
    }
    public void saveTran(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TranService service = (TranService) ServiceFactory.getService(new TranServiceImpl());
        Tran tran = BeanUtil.getObjectFromMap(request.getParameterMap(), Tran.class);
        User user = (User) request.getSession().getAttribute("user");
        assert tran != null;
        tran.setId(UUIDUtil.getUUID());
        tran.setCreateBy(user.getId());
        tran.setCreateTime(DateTimeUtil.getSysTime());
        service.save(tran, request.getParameter("customerName"));
        response.sendRedirect(Path.PROJECT_PATH + "workbench/transaction/index.jsp");
    }
}
