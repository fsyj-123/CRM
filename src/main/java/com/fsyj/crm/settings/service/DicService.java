package com.fsyj.crm.settings.service;

import com.fsyj.crm.settings.bean.DicValue;

import java.util.List;
import java.util.Map;

/**
 * @author fsyj
 */
public interface DicService {
    /**
     * 获取字典数据，map的key为dicType
     * @return 字典数据
     */
    Map<String, List<DicValue>> getDicMap();
}
