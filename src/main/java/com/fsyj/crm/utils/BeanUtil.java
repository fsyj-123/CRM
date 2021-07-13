package com.fsyj.crm.utils;

import org.apache.commons.beanutils.BeanUtils;

import java.lang.reflect.InvocationTargetException;
import java.util.Map;

public class BeanUtil {
    public static <T> T getObjectFromMap(Map<String, String[]> paramMap, Class<T> type) {
        T instance = null;
        try {
            if (paramMap == null) {
                return null;
            }
            instance = type.getDeclaredConstructor().newInstance();
            BeanUtils.populate(instance, paramMap);
        } catch (InstantiationException | IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
            e.printStackTrace();
        }
        return instance;
    }
}
