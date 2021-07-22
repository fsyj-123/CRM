package com.fsyj.crm.workbench.web.controller;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.*;
import com.fsyj.crm.web.controller.BaseServlet;
import com.fsyj.crm.workbench.bean.Clue;
import com.fsyj.crm.workbench.service.ClueService;
import com.fsyj.crm.workbench.service.impl.ClueServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fsyj
 */
public class ClueServlet extends BaseServlet {
    public void getUserList(HttpServletRequest request, HttpServletResponse response) {
        try {
            UserService service = (UserService) ServiceFactory.getService(new UserServiceImpl());
            List<User> userList = service.getUserList();
            HashMap<String, Object> map = new HashMap<>(2);
            map.put("success", true);
            map.put("userList", userList);
            PrintJson.printJsonObj(response, map);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }
    public void saveClue(HttpServletRequest request, HttpServletResponse response) {
        try {
            ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
            Map<String, String[]> parameterMap = request.getParameterMap();
            Clue clue = BeanUtil.getObjectFromMap(parameterMap, Clue.class);
            User user = (User) request.getSession().getAttribute("user");
            assert clue != null;
            clue.setId(UUIDUtil.getUUID());
            clue.setCreateBy(user.getId());
            clue.setCreateTime(DateTimeUtil.getSysTime());
            System.out.println(clue);
            clueService.saveClue(clue);
            PrintJson.printJsonFlag(response,true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }
}
