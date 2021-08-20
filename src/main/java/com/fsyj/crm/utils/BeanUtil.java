package com.fsyj.crm.utils;

import org.apache.commons.beanutils.BeanUtils;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;

import static com.fsyj.crm.utils.constStrings.MethodName.*;

/**
 * @author fsyj
 */
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

    /**
     * 创建一个对象，并设置id、创建者ID、创建时间
     *
     * @param tClass    对象类型
     * @param creatorId id
     * @param <T>
     * @return
     */
    public static <T> T createObject(Class<T> tClass, String creatorId) {
        T instance = null;
        try {
            instance = tClass.newInstance();
            String uuid = UUIDUtil.getUUID();
            String sysTime = DateTimeUtil.getSysTime();
            try {
                // 获取set方法 -- id
                Method setId = tClass.getDeclaredMethod(SET_ID, String.class);
                setId.invoke(instance, uuid);
            } catch (IllegalAccessException | NoSuchMethodException | InvocationTargetException e) {
                e.printStackTrace();
            }

            try {
                // 设置createdBy
                Method setCreateBy = tClass.getDeclaredMethod(SET_CREATE_BY, String.class);
                setCreateBy.invoke(instance, creatorId);
            } catch (IllegalAccessException | NoSuchMethodException | InvocationTargetException e) {
                e.printStackTrace();
            }


            try {
                // 设置创建时间
                Method setCreateTime = tClass.getDeclaredMethod(SET_CREATE_TIME, String.class);
                setCreateTime.invoke(instance, sysTime);
            } catch (IllegalAccessException | NoSuchMethodException | InvocationTargetException e) {
                e.printStackTrace();
            }
        } catch (InstantiationException | IllegalAccessException e) {
            e.printStackTrace();
        }


        return instance;
    }

    /**
     * 将convertor中的属性值复制到toConvert中
     * 已经赋值过的属性将不被赋值
     * @param toConvert not null
     * @param convertor not null
     * @param <T>
     * @param <A>
     * @return
     */
    public static <T, A> void convert(T toConvert, A convertor) {
        assert toConvert != null && convertor != null;
        Class<?> convertorClass = convertor.getClass();
        Class<?> toConvertClass = toConvert.getClass();
        /*
        获取待转换类的属性，通过属性名去convertor类中获取get方法
        get方法不需要参数
         */
        Field[] fields = toConvertClass.getDeclaredFields();
        for (Field field : fields) {
            String methodName = field.getName();
            // 首字母大写
            methodName = methodName.substring(0, 1).toUpperCase() + methodName.substring(1);
            try {
                // 首先通过待转换类的get方法判断当前属性是否已被赋值
                Method valueMethod = toConvertClass.getDeclaredMethod("get" + methodName);
                Object result = valueMethod.invoke(toConvert);
                if (result != null) {
                    // 如果已有值则跳过
                    continue;
                }

                Method getMethod = convertorClass.getDeclaredMethod("get" + methodName);
                Object value = getMethod.invoke(convertor);

                // 通过set方法复制属性值
                Method setMethod = toConvertClass.getDeclaredMethod("set" + methodName, field.getType());
                setMethod.invoke(toConvert, value);
            } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
                System.out.println(e.getMessage());
            }
        }
    }
}
