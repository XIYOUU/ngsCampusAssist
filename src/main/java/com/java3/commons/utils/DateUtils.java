package com.java3.commons.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 对Data类型数据进行处理的工具类
 */
public class DateUtils {

    /**
     * 对指定的Data对象格式化：yyyy-MM-dd HH:hh:ss
     * @param date
     * @return
     */
    public static String formatDateTime(Date date){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:hh:ss");
        String dataStr=sdf.format(new Date());
        return dataStr;
    }

    /**
     * 对指定的Data对象格式化：yyyy-MM-dd HH:hh
     * @param date
     * @return
     */
    public static String formatDateMinute(Date date){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:hh");
        String dataStr=sdf.format(new Date());
        return dataStr;
    }

    /**
     * 对指定的Data对象格式化：yyyy-MM-dd
     * @param date
     * @return
     */
    public static String formatDate(Date date){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
        String dataStr=sdf.format(new Date());
        return dataStr;
    }

    /**
     * 对指定的Data对象格式化：HH:hh:ss
     * @param date
     * @return
     */
    public static String formatTime(Date date){
        SimpleDateFormat sdf=new SimpleDateFormat("HH:hh:ss");
        String dataStr=sdf.format(new Date());
        return dataStr;
    }

}
