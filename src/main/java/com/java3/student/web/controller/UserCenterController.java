package com.java3.student.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserCenterController {
    /**
     * 跳转到user首页
     * */
    @RequestMapping("/student/user/user_info.do")
    public String index(){
        //请求转发
        return "student/user/user_info";
    }
}
