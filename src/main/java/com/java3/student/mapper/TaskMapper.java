package com.java3.student.mapper;

import com.java3.settings.domain.User;
import com.java3.student.domain.Task;

import java.util.List;
import java.util.Map;

public interface TaskMapper {

    /**
     * 查询所有的任务
     * @param
     * @return
     */
    List<Task> selectAllTask();

    /**
     * 根据条件分页查询所有的任务
     * */
    List<Task> selectAllTaskByConditionForPage(Map<String,Object> map);

    /**
     * 根据条件分页查询所有的任务数量
     * */
    int selectCountOfTaskByCondition(Map<String,Object> map);


    /**
     * 查询我的任务
     * */
    List<Task> selectAllDealTask(Map<String,Object> map);


    /**
     * 根据用户的id和任务的id接取任务
     * */
    int updateDealTaskByIds(Map<String,Object> map);


    /**
     * 查询我的发布
     * */
    List<Task> selectAllSaveTask(Map<String,Object> map);

    /**
     * 新增任务
     * */
    int insertTask(Task task);


    /**
     * 根据ids批量删除任务
     * */
    int deleteTaskByIds(String[] ids);

    /**
     * 根据id查询任务
     * */
    Task selectTaskById(String id);

    /**
     * 保存修改的任务
     * */
    int updateTask(Task Task);

    /**
     * 根据ids完成指定任务
     * */
    int finshTaskByIds(String[] ids);
}