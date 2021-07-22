package com.fsyj.crm.settings.service;

import com.fsyj.crm.settings.bean.DicValue;
import com.fsyj.crm.settings.service.impl.DicServiceImpl;
import com.fsyj.crm.utils.ServiceFactory;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static org.junit.Assert.*;

public class DicServiceTest {

    @Test
    public void getDicMap() {
        DicService dicService = (DicService) ServiceFactory.getService(new DicServiceImpl());
        Map<String, List<DicValue>> dicMap = dicService.getDicMap();
        Set<Map.Entry<String, List<DicValue>>> entries = dicMap.entrySet();
        for (Map.Entry<String, List<DicValue>> entry : entries) {
            List<DicValue> value = entry.getValue();
            System.out.print(entry.getKey() + ": " );
            for (DicValue dicValue : value) {
                System.out.print(dicValue.getText() + ", ");
            }
            System.out.println();
        }
    }
}