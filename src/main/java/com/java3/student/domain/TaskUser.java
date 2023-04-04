package com.java3.student.domain;

import com.java3.settings.domain.User;


/*一对一*/
public class TaskUser extends Task {
     String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
