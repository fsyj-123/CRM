package com.fsyj.crm.utils;

import org.junit.Test;

import static org.junit.Assert.*;

public class MD5UtilTest {

    @Test
    public void getMD5() {
        String md5 = MD5Util.getMD5("123");
        System.out.println(md5);
        System.out.println(md5.length());
    }
}