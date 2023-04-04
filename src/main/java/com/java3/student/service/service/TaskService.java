package com.java3.student.service.service;


import com.java3.settings.domain.User;
import com.java3.student.domain.Task;

import java.util.List;
import java.util.Map;

public interface TaskService {

    List<Task> queryAllTask();

    List<Task> queryAllTaskByConditionForPage(Map<String,Object> map);

    int queryCountOfTaskByCondition(Map<String,Object> map);

    List<Task> queryAllDealTask(Map map);

    int updateDealTaskByIds(Map map);

    List<Task> queryAllSaveTask(Map map);

    int insertTask(Task task);

    int deleteTaskByIds(String[] ids);

    Task queryTaskById(String id);

    int saveEditTask(Task Task);

    int finshTaskByIds(String[] ids);

}
