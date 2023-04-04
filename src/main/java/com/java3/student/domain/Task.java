package com.java3.student.domain;

import com.java3.settings.domain.User;

public class Task {
    int id;         //主键id
    String brief;   //简介
    int state;      //状态
    int createBy;   //发布人id
    int receiveBy;  //接取人id
    String startDate;//开始日期
    String endDate;//结束日期
    String createTime; //创建时间
    int cost;          //赏金

    User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    public int getReceiveBy() {
        return receiveBy;
    }

    public void setReceiveBy(int receiveBy) {
        this.receiveBy = receiveBy;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public int getCost() {
        return cost;
    }

    public void setCost(int cost) {
        this.cost = cost;
    }
}
