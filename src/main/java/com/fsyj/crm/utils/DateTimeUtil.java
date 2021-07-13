package com.fsyj.crm.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {

    public static String getSysTime() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  // 取得19位时间字符串
        Date date = new Date();
        return sdf.format(date);
    }

}
