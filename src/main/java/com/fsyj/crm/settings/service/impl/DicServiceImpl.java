package com.fsyj.crm.settings.service.impl;

import com.fsyj.crm.settings.bean.DicType;
import com.fsyj.crm.settings.bean.DicValue;
import com.fsyj.crm.settings.mapper.DicTypeMapper;
import com.fsyj.crm.settings.mapper.DicValueMapper;
import com.fsyj.crm.settings.service.DicService;
import com.fsyj.crm.utils.SqlSessionUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author fsyj
 */
public class DicServiceImpl implements DicService {
    @Override
    public Map<String, List<DicValue>> getDicMap() {
        DicTypeMapper typeMapper = SqlSessionUtil.getSqlSession().getMapper(DicTypeMapper.class);
        DicValueMapper valueMapper = SqlSessionUtil.getSqlSession().getMapper(DicValueMapper.class);
        List<DicType> dicTypes = typeMapper.queryAll();
        List<DicValue> dicValues = valueMapper.getAllDicValue();
        int temp = dicValues.size() / dicTypes.size();
        Map<String, List<DicValue>> result = new HashMap<>(dicTypes.size());
        for (DicType dicType : dicTypes) {
            result.put(dicType.getCode(),new ArrayList<>(temp));
        }
        for (DicValue dicValue : dicValues) {
            if (result.containsKey(dicValue.getTypeCode())) {
                result.get(dicValue.getTypeCode()).add(dicValue);
            }
        }
        return result;
    }
}
