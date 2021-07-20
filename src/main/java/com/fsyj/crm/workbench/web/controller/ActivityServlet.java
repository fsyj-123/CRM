package com.fsyj.crm.workbench.web.controller;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.settings.service.UserService;
import com.fsyj.crm.settings.service.impl.UserServiceImpl;
import com.fsyj.crm.utils.*;
import com.fsyj.crm.vo.PageNavigate;
import com.fsyj.crm.web.controller.BaseServlet;
import com.fsyj.crm.workbench.bean.Activity;
import com.fsyj.crm.workbench.bean.ActivityRemark;
import com.fsyj.crm.workbench.service.ActivityRemarkService;
import com.fsyj.crm.workbench.service.ActivityService;
import com.fsyj.crm.workbench.service.impl.ActivityRemarkServiceImpl;
import com.fsyj.crm.workbench.service.impl.ActivityServiceImpl;

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
            /*这里直接返回两个值在前端解析data会出现错误
            PrintJson.printJsonFlag(response, true);
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
            PageNavigate<Activity> pageList = activityService.getPageList(paramMap);
            PrintJson.printJsonObj(response, pageList);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void deleteActivities(HttpServletRequest request, HttpServletResponse response) {
        try {
            String[] ids = request.getParameterValues("id[]");
            if (ids == null || ids.length == 0) {
                PrintJson.printJsonFlag(response, false);
                return;
            }
            activityService.deleteActivity(ids);
            PrintJson.printJsonFlag(response, true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void getUserListAndAct(HttpServletRequest request, HttpServletResponse response) {
        try {
            List<User> userList = userService.getUserList();
            Activity activity = activityService.getActivity(request.getParameter("id"));
            HashMap<String, Object> map = new HashMap<>();
            map.put("success", true);
            map.put("userList", userList);
            map.put("activity", activity);
            PrintJson.printJsonObj(response, map);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void updateActivity(HttpServletRequest request, HttpServletResponse response) {
        try {
            Map<String, String[]> parameterMap = request.getParameterMap();
            Activity activity = BeanUtil.getObjectFromMap(parameterMap, Activity.class);
            if (activity == null) {
                return;
            }
            activity.setEditTime(DateTimeUtil.getSysTime());
            User operator = (User) request.getSession().getAttribute("user");
            activity.setEditBy(operator.getId());
            activityService.updateActivity(activity);
            PrintJson.printJsonFlag(response, true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void detail(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            System.out.println(id);
            Activity activity = activityService.getDetailByID(id);
            request.setAttribute("activity", activity);
            System.out.println(activity);
            request.getRequestDispatcher("/workbench/activity/detail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void activityRemarkList(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            ActivityRemarkService ars = (ActivityRemarkService) ServiceFactory.getService(new ActivityRemarkServiceImpl());
            List<ActivityRemark> remarkList = ars.getRemarkList(id);
            System.out.println(remarkList);
            HashMap<String, Object> map = new HashMap<>(2);
            map.put("remarkList", remarkList);
            map.put("success", true);
            PrintJson.printJsonObj(response, map);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void deleteRemark(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            ActivityRemarkService service = (ActivityRemarkService) ServiceFactory.getService(new ActivityRemarkServiceImpl());
            service.deleteRemark(id);
            PrintJson.printJsonFlag(response,true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void updateRemark(HttpServletRequest request, HttpServletResponse response) {
        try {
            String id = request.getParameter("id");
            String content = request.getParameter("content");
            User user = (User) request.getSession().getAttribute("user");
            ActivityRemarkService service = (ActivityRemarkService) ServiceFactory.getService(new ActivityRemarkServiceImpl());
            service.updateRemark(id,content,user.getId());
            PrintJson.printJsonFlag(response,true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }

    public void saveRemark(HttpServletRequest request, HttpServletResponse response) {
        try {
            String content = request.getParameter("content");
            String activityId = request.getParameter("activityId");
            User user = (User) request.getSession().getAttribute("user");
            String creator = user.getId();
            ActivityRemark activityRemark = new ActivityRemark();
            activityRemark.setId(UUIDUtil.getUUID());
            activityRemark.setNoteContent(content);
            activityRemark.setCreateTime(DateTimeUtil.getSysTime());
            activityRemark.setCreateBy(creator);
            activityRemark.setEditFlag("0");
            activityRemark.setActivityId(activityId);
            ActivityRemarkService service = (ActivityRemarkService) ServiceFactory.getService(new ActivityRemarkServiceImpl());
            service.createRemark(activityRemark);
            PrintJson.printJsonFlag(response,true);
        } catch (Exception e) {
            e.printStackTrace();
            PrintJson.printJsonFlag(response, false);
        }
    }
}
