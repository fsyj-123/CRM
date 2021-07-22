package com.fsyj.crm.settings.mapper;

import com.fsyj.crm.settings.bean.DicType;
import com.fsyj.crm.utils.SqlSessionUtil;
import org.junit.Test;

import java.util.List;

import static org.junit.Assert.*;

public class DicTypeMapperTest {

    @Test
    public void queryAll() {
        DicTypeMapper mapper = SqlSessionUtil.getSqlSession().getMapper(DicTypeMapper.class);
        List<DicType> dicTypes = mapper.queryAll();
        for (DicType dicType : dicTypes) {
            System.out.println(dicType);
        }
    }
}