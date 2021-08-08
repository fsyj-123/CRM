package com.fsyj.crm.workbench.web.controller;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.*;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.web.controller.BaseServlet;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.bean.Clue;
import com.fsyj.crm.workbench.service.ClueService;
import com.fsyj.crm.workbench.service.impl.ClueServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
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
            PrintJson.printJsonFlag(response, true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void page(HttpServletRequest request, HttpServletResponse response) {
        try {
            ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
            Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
            Integer pageSize = Integer.valueOf(request.getParameter("pageSize"));
            PageNavigate<Clue> clueList = clueService.getPageList(pageNo, pageSize);
            PrintJson.printJsonObj(response, clueList);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Clue clue = clueService.queryClueById(request.getParameter("id"));
        request.setAttribute("clue", clue);
        request.getRequestDispatcher("/workbench/clue/detail.jsp").forward(request, response);
    }

    public void getRelationship(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
            String clueId = request.getParameter("clueId");
            List<Activity> activities = clueService.getRelation(clueId);
            HashMap<String, Object> map = new HashMap<>(2);
            map.put("success", true);
            map.put("relationship", activities);
            PrintJson.printJsonObj(response, map);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }
    public void bind(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
            String activityIds = request.getParameter("activityId");
            String[] aids = activityIds.substring(1, activityIds.length() - 1).split(",");
            String clueId = request.getParameter("clueId");
            clueService.bindActivity(aids,clueId);
            PrintJson.printJsonFlag(response,true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void removeRelation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            ClueService clueService = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
            clueService.removeRelation(request.getParameter("id"));
            PrintJson.printJsonFlag(response,true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }
}
