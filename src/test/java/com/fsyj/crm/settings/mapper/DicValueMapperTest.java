package com.fsyj.crm.settings.mapper;

import com.fsyj.crm.settings.bean.DicValue;
import com.fsyj.crm.utils.SqlSessionUtil;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class DicValueMapperTest {

    @Test
    public void getAllDicValue() {
        DicValueMapper mapper = SqlSessionUtil.getSqlSession().getMapper(DicValueMapper.class);
        List<DicValue> allDicValue = mapper.getAllDicValue();
        for (DicValue dicValue : allDicValue) {
            System.out.println(dicValue);
        }
    }
}