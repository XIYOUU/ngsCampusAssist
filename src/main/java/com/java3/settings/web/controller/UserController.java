package com.java3.settings.web.controller;

import com.java3.commons.contains.Contains;
import com.java3.commons.domain.ReturnObject;
import com.java3.commons.utils.DateUtils;
import com.java3.settings.domain.User;

import com.java3.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * url要和controller方法处理完请求之后，响应信息返回的资源目录保持一致
     */
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin() {
        //请求转发到登录页面
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login.do")
    public @ResponseBody
    Object login(String loginAct, String loginPwd, String isRemPwd, HttpServletResponse response, HttpServletRequest request, HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);
        //调用service层方法，查询用户
        User user = userService.queryUserByLoginActAndPwd(map);
        //根据查询结果，生成响应信息
        ReturnObject returnObject = new ReturnObject();
        if (user == null) {
            //登录失败，用户名或密码错误
            returnObject.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("用户名或者密码错误");
        } else {//进一步判断用户是否合法

            //登录成功
            returnObject.setCode(Contains.RETURN_OBJECT_CODE_SUCCESS);

            //把user存到session中,作用是所有页面都能使用到用户名
            session.setAttribute(Contains.SESSION_USER, user);  //username
//            session.setAttribute(, );
//            System.out.println("user:" + user);

            if ("true".equals(isRemPwd)) {
                //如果需要记住密码，则往外写Cookie
                Cookie c1 = new Cookie("loginAct", user.getLogAct());
                c1.setMaxAge(10 * 24 * 60 * 60);
                response.addCookie(c1);

                Cookie c2 = new Cookie("loginPwd", user.getLogPwd());
                c2.setMaxAge(10 * 24 * 60 * 60);
                response.addCookie(c2);
            } else {
                //不能删别人电脑上的东西，但是要删除Cookie，可以把Cookie的过期时间设置为0
                Cookie c1 = new Cookie("loginAct", "1");
                c1.setMaxAge(0);
                response.addCookie(c1);

                Cookie c2 = new Cookie("loginPwd", "1");
                c2.setMaxAge(0);
                response.addCookie(c2);
            }


        }
//        System.out.println("code:" + returnObject.getCode());
//        System.out.println("message:" + returnObject.getMessage());
//        System.out.println("data:" + returnObject.getRetData());
        return returnObject;
    }

    @RequestMapping("/settings/qx/user/logout.do")
    public String logout(HttpServletResponse response, HttpSession session){
        //清空Cookie
        Cookie c1=new Cookie("loginAct","1");
        c1.setMaxAge(0);
        response.addCookie(c1);

        Cookie c2=new Cookie("loginPwd","1");
        c2.setMaxAge(0);
        response.addCookie(c2);
        //清空session
        session.invalidate();
        //跳转到首页

        //请求转发，发一次请求，显示的是Controller的地址/settings/qx/user/logout.do
        //重定向，发2次请求，显示的是完整地址
        return "redirect:/";

    }
}
