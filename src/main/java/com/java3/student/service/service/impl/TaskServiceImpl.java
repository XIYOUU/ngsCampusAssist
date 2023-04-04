package com.java3.student.service.service.impl;


import com.java3.settings.domain.User;
import com.java3.student.domain.Task;
import com.java3.student.mapper.TaskMapper;
import com.java3.student.service.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

//Service加入Spring容器
@Service("taskService")
public class TaskServiceImpl implements TaskService {

    @Autowired
    TaskMapper taskMapper;

    @Override
    public List<Task> queryAllTask() {
        return taskMapper.selectAllTask();
    }

    @Override
    public List<Task> queryAllTaskByConditionForPage(Map<String, Object> map) {
        return taskMapper.selectAllTaskByConditionForPage(map);
    }

    @Override
    public int queryCountOfTaskByCondition(Map<String, Object> map) {
        return taskMapper.selectCountOfTaskByCondition(map);
    }

    @Override
    public List<Task> queryAllDealTask(Map map) {
        return taskMapper.selectAllDealTask(map);
    }

    @Override
    public int updateDealTaskByIds(Map map) {
        return taskMapper.updateDealTaskByIds(map);
    }

    @Override
    public List<Task> queryAllSaveTask(Map map) {
        return taskMapper.selectAllSaveTask(map);
    }


    @Override
    public int insertTask(Task task) {
        return taskMapper.insertTask(task);
    }

    @Override
    public int deleteTaskByIds(String[] ids) {
        return taskMapper.deleteTaskByIds(ids);
    }

    @Override
    public int saveEditTask(Task task) {
        return taskMapper.updateTask(task);
    }

    @Override
    public Task queryTaskById(String id) {
        return taskMapper.selectTaskById(id);
    }

    @Override
    public int finshTaskByIds(String[] ids) {
        return taskMapper.finshTaskByIds(ids);
    }
}
