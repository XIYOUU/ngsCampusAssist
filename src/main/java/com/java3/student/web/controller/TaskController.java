package com.java3.student.web.controller;

import com.java3.commons.contains.Contains;
import com.java3.commons.domain.ReturnObject;
import com.java3.commons.utils.DateUtils;
import com.java3.settings.domain.User;
import com.java3.student.domain.Task;
import com.java3.student.service.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TaskController {

    @Autowired
    TaskService taskService;

    @RequestMapping("/student/task/deal.do")
    public String deal(HttpServletRequest request){
        //请求转发
        return "student/task/deal";
    }

    @RequestMapping("/student/task/queryAllDealTask.do")
    public @ResponseBody Object queryAllDealTask(HttpServletRequest request){
        //根据用户id查任务
        //用户已登录，就一定存在user对象在session中
        User sessionUser =(User) request.getSession().getAttribute("sessionUser");
        Map<String,Object> map =new HashMap();
        map.put("sessionUser",sessionUser);
//        int id = sessionUser.getId();
        //查询数据
        List<Task> tasks = taskService.queryAllDealTask(map);
        Map<String,Object> retMap=new HashMap<>();
        retMap.put("tasks",tasks);
        return retMap;
    }

    @RequestMapping("/student/task/updateDealTaskByIds.do")
    public @ResponseBody Object updateDealTaskByIds(String[] ids, HttpServletRequest request){

        //封装参数
        User sessionUser =(User) request.getSession().getAttribute("sessionUser");
        Map<String,Object> map =new HashMap();
        map.put("sessionUser",sessionUser);
        map.put("ids",ids);
        System.out.println(ids);

        int row = taskService.updateDealTaskByIds(map);
        ReturnObject returnObject=new ReturnObject();
        try{
            if(row>0){
                //修改成功
                returnObject.setCode(Contains.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                //修改失败
                returnObject.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙，请稍后重试");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙，请稍后重试");
        }
        return returnObject;
    }

    @RequestMapping("/student/task/queryAllSaveTask.do")
    public @ResponseBody Object queryAllSaveTask(HttpServletRequest request){
        User sessionUser =(User) request.getSession().getAttribute("sessionUser");
        Map<String,Object> map =new HashMap();
        map.put("sessionUser",sessionUser);
        List<Task> tasks = taskService.queryAllSaveTask(map);
        Map<String,Object> retMap=new HashMap<>();
        retMap.put("tasks",tasks);
        return retMap;
    }

    @RequestMapping("/student/task/save.do")
    public String save(HttpServletRequest request){
        //请求转发
        return "student/task/save";
    }



    @RequestMapping("/student/task/insertTask.do")
    public @ResponseBody Object insertTask(Task task,HttpServletRequest request){
        //封装参数
        User sessionUser =(User) request.getSession().getAttribute("sessionUser");

        task.setState(1);
        task.setCreateBy(sessionUser.getId());
        task.setCreateTime(DateUtils.formatDateMinute(new Date()));

        int row = taskService.insertTask(task);

        //根据响应信息返回结果
        ReturnObject returnObject=new ReturnObject();
        try{
            if(row>0){
                //修改成功
                returnObject.setCode(Contains.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                //修改失败
                returnObject.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙，请稍后重试");
            }
        }catch (Exception e){
            e.printStackTrace();
            returnObject.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
            returnObject.setMessage("系统忙，请稍后重试");
        }
        return returnObject;
    }

    @RequestMapping("/student/task/deleteTaskByIds.do")
    public @ResponseBody Object deleteTaskByIds(String[] id){
        ReturnObject object=new ReturnObject();
        try{
            //调用service层删除活动
            int ids = taskService.deleteTaskByIds(id);
            //根据结果生成响应信息
            if(ids>0){
                object.setCode(Contains.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                object.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
                object.setMessage("系统忙，请稍后重试");
            }
        }catch (Exception e){
            e.printStackTrace();
            object.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
            object.setMessage("系统忙，请稍后重试");
        }

        return object;
    }

    @RequestMapping("/student/task/queryTaskById.do")
    public @ResponseBody Object queryTaskById(String id){

        Task task = taskService.queryTaskById(id);
        //根据查询结果，返回响应信息
        return task;
    }


    @RequestMapping("/student/task/saveEditTask.do")
    public @ResponseBody Object saveEditTask(Task task){
//        User user=(User)session.getAttribute(Contains.SESSION_USER);
        //封装参数
//        activity.setEditBy(DateUtils.formatDateTime(new Date()));
//        activity.setEditBy(user.getId());

        ReturnObject returnObject=new ReturnObject();

        try{
            //调用service层方法，保存修改的市场活动
            int ret=taskService.saveEditTask(task);

            if(ret>0){
                returnObject.setCode(Contains.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                returnObject.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
                returnObject.setMessage("系统忙，请稍后重试");
            }

        }catch (Exception e){
            e.printStackTrace();
        }
        return returnObject;
    }

    @RequestMapping("/student/task/finshTaskByIds.do")
    public @ResponseBody Object finshTaskByIds(String[] id){
        ReturnObject object=new ReturnObject();
        try{
            int ids = taskService.finshTaskByIds(id);
            //根据结果生成响应信息
            if(ids>0){
                object.setCode(Contains.RETURN_OBJECT_CODE_SUCCESS);
            }else{
                object.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
                object.setMessage("系统忙，请稍后重试");
            }
        }catch (Exception e){
            e.printStackTrace();
            object.setCode(Contains.RETURN_OBJECT_CODE_FAIL);
            object.setMessage("系统忙，请稍后重试");
        }

        return object;
    }


}
