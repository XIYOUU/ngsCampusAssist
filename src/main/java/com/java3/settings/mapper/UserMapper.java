package com.java3.settings.mapper;

import com.java3.settings.domain.User;

import java.util.Map;

public interface UserMapper {

    /**
     * 根据账号和密码查询用户
     * @param map
     * @return
     */
    User selectUserByLoginActAndPwd(Map<String, Object> map);


}