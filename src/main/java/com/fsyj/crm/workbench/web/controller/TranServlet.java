package com.fsyj.crm.workbench.web.controller;

import com.fsyj.crm.settings.bean.DicValue;
import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.*;
import com.fsyj.crm.utils.constStrings.Path;
import com.fsyj.crm.vo.EchartsDataPair;
import com.fsyj.crm.web.controller.BaseServlet;
import com.fsyj.crm.workbench.bean.Customer;
import com.fsyj.crm.workbench.bean.Tran;
import com.fsyj.crm.workbench.bean.TranHistory;
import com.fsyj.crm.workbench.service.CustomerService;
import com.fsyj.crm.workbench.service.TranService;
import com.fsyj.crm.workbench.service.impl.CustomerServiceImpl;
import com.fsyj.crm.workbench.service.impl.TranServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
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

    public void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        String id = request.getParameter("id");
        Tran tran = tranService.query(id);
        // 确定当前阶段下标
        currentIndex(request, tran);

        request.setAttribute("tran", tran);
        request.getRequestDispatcher("/workbench/transaction/detail.jsp").forward(request, response);
    }

    private void currentIndex(HttpServletRequest request, Tran tran) {
        // 确定当前阶段下标
        List<DicValue> stages = (List<DicValue>) request.getServletContext().getAttribute("stage");
        int size = stages.size();
        for (int i = 0; i < size; i++) {
            if (tran.getStage().equals(stages.get(i).getValue())) {
                request.setAttribute("currentStageIndex", i);
                break;
            }
        }
    }

    public void getHistoryList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        List<TranHistory> histories = tranService.getHistoryList(request.getParameter("tranId"));
        PrintJson.printJsonObj(response, histories);
    }

    public void stageChange(HttpServletRequest request, HttpServletResponse response) {
        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        String tranId = request.getParameter("tranId");
        String stage = request.getParameter("stage");
        Tran tran = tranService.query(tranId);
        if (tran == null || stage == null || "".equals(stage) || tran.getStage().equals(stage)) {
            // 更改参数不合规或阶段并未改变
            return;
        }
        User user = (User) request.getSession().getAttribute("user");
        tran = tranService.changeStage(tran, stage, user.getId());
        PrintJson.printJsonObj(response, tran);
    }
    public void getGroupData(HttpServletRequest request, HttpServletResponse response) {
        TranService tranService = (TranService) ServiceFactory.getService(new TranServiceImpl());
        List<EchartsDataPair> groupData = tranService.getGroupData();
        PrintJson.printJsonObj(response, groupData);
    }
}
