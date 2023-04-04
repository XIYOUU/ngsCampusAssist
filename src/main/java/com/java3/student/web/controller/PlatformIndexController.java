package com.java3.student.web.controller;


import com.java3.student.domain.Task;
import com.java3.student.service.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class PlatformIndexController {

    @Autowired
    private TaskService taskService;
//    @Autowired
//    private TaskService activityService;

    /**
     * 跳转到platform_index首页
     * */
    @RequestMapping("/student/platform_index/index.do")
    public String index(){
        //请求转发
        return "student/platform_index/index";
    }


    /**
     * 根据页号和页数返回查询结果
     * */
    @RequestMapping("/student/platform_index/queryByConditionForPage.do")
    public @ResponseBody Object queryTaskByConditionForPage(String brief,int pageNo,int pageSize){
        //封装参数
        Map<String,Object> map=new HashMap<>();
        map.put("brief",brief);
        map.put("pageNo",(pageNo-1)*pageSize);
        map.put("pageSize",pageSize);

        //查询数据
        List<Task> tasks = taskService.queryAllTaskByConditionForPage(map);
        int totalRows=taskService.queryCountOfTaskByCondition(map);
        Map<String,Object> retMap=new HashMap<>();
        retMap.put("tasks",tasks);
        retMap.put("totalRows",totalRows);
        return retMap;
    }
}
