package com.java3.settings.service;

import com.java3.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    User queryUserByLoginActAndPwd(Map<String, Object> map);

//    List<User> qurreyAllUser();
}
