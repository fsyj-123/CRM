package com.fsyj.crm.web.listener;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fsyj.crm.settings.bean.DicValue;
import com.fsyj.crm.settings.service.DicService;
import com.fsyj.crm.settings.service.impl.DicServiceImpl;
import com.fsyj.crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import java.util.*;

/**
 * @author fsyj
 */
public class ServletContextListener implements javax.servlet.ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        DicService dicService = (DicService) ServiceFactory.getService(new DicServiceImpl());
        Map<String, List<DicValue>> dicMap = dicService.getDicMap();
        Set<Map.Entry<String, List<DicValue>>> entries = dicMap.entrySet();
        ServletContext servletContext = sce.getServletContext();
        for (Map.Entry<String, List<DicValue>> entry : entries) {
            servletContext.setAttribute(entry.getKey(), entry.getValue());
        }

        /*
         处理阶段与可能性的对应关系
         Properties类用于处理不含中文或Unicode编码的键值对
         */
        Map<String, String> map = new HashMap<>(9);
        ResourceBundle stage2Possibility = ResourceBundle.getBundle("Stage2Possibility");
        Enumeration<String> keys = stage2Possibility.getKeys();
        while (keys.hasMoreElements()) {
            String key = keys.nextElement();
            String value = stage2Possibility.getString(key);
            map.put(key, value);
        }
        // 将阶段Map转换为json
        ObjectMapper mapper = new ObjectMapper();
        String mapJson = "";
        try {
            mapJson = mapper.writeValueAsString(map);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        servletContext.setAttribute("s2p", mapJson);


        // 获取阶段信息
        List<DicValue> stages = dicMap.get("stage");
        int size = stages.size();
        for (int i = 0; i < size; i++) {
            String possibility = map.get(stages.get(i).getText());
            if ("0".equals(possibility)) {
                servletContext.setAttribute("stagePoint", i);
                break;
            }
        }
    }


}
