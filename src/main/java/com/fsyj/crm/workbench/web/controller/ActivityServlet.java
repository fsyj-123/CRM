package com.fsyj.crm.workbench.web.controller;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.*;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.web.controller.BaseServlet;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.service.ActivityService;
import com.fsyj.crm.workbench.service.serviceImpl.ActivityServiceImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityServlet extends BaseServlet {
    private UserService userService = (UserService) ServiceFactory.getService(new UserServiceImpl());
    private ActivityService activityService = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

    public void getUserList(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<User> userList = userService.getUserList();
            // 这里直接返回两个值在前端解析data会出现错误
            /*PrintJson.printJsonFlag(response, true);
            PrintJson.printJsonObj(response, userList);*/
            HashMap<String, Object> map = new HashMap<>(2);
            map.put("success", true);
            map.put("userList", userList);
            PrintJson.printJsonObj(response, map);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void saveActivity(HttpServletRequest request, HttpServletResponse response) {
        try {
            Map<String, String[]> parameterMap = request.getParameterMap();
            Activity activity = BeanUtil.getObjectFromMap(parameterMap, Activity.class);

            assert activity != null;
            activity.setCreateTime(DateTimeUtil.getSysTime());
            User user = (User) request.getSession().getAttribute("user");
            activity.setCreateBy(user.getId());
            activity.setId(UUIDUtil.getUUID());
            System.out.println(activity);
            activityService.saveActivity(activity);
            PrintJson.printJsonFlag(response, true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void getPageList(HttpServletRequest request, HttpServletResponse response) {
        try {
            String name = request.getParameter("name");
            String owner = request.getParameter("owner");
            String startTime = request.getParameter("startTime");
            String endTime = request.getParameter("endTime");
            Integer pageNo = Integer.valueOf(request.getParameter("pageNo"));
            Integer pageSize = Integer.valueOf(request.getParameter("pageSize"));
            Integer beginIndex = (pageNo - 1) * pageSize;
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("name", name);
            paramMap.put("owner", owner);
            paramMap.put("startDate", startTime);
            paramMap.put("endDate", endTime);
            paramMap.put("pageSize", pageSize);
            paramMap.put("pageNo", pageNo);
            paramMap.put("beginIndex", beginIndex);
            for (Map.Entry<String, Object> entry : paramMap.entrySet()) {
                System.out.println(entry);
            }
            PageNavigate<Activity> pageList = activityService.getPageList(paramMap);
            PrintJson.printJsonObj(response, pageList);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }
}
