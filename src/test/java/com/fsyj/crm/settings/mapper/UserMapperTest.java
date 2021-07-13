package com.fsyj.crm.settings.mapper;

import com.fsyj.crm.settings.bean.User;
import com.fsyj.crm.utils.SqlSessionUtil;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;

import static org.junit.Assert.*;

public class UserMapperTest {

    @Test
    public void queryUser() {
        try (SqlSession session = SqlSessionUtil.getSqlSession()) {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.queryUser("123", "123");
            session.commit();
            System.out.println(user);
        }
    }
}