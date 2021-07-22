package com.fsyj.crm.web.listener;

import com.fsyj.crm.settings.bean.DicValue;
import com.fsyj.crm.settings.service.DicService;
import com.fsyj.crm.settings.service.impl.DicServiceImpl;
import com.fsyj.crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
            servletContext.setAttribute(entry.getKey(),entry.getValue());
        }
    }
}
