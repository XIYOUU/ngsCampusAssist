package com.java3.student.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StudentIndexController {
    @RequestMapping("/student/index.do")
    public String index(){
        //跳转到业务主页面
        return "student/index";
    }
}
