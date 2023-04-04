package com.java3.settings.domain;

public class User {

    int id ;            //主键id
    String logAct;      //账号
    String name;        //姓名
    String logPwd;      //密码
    String tel;         //联系电话
    int fans;           //粉丝
    int follow;         //关注
    int acceptOrder;    //总接单量
    int balance;        //余额

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getLogAct() {
        return logAct;
    }

    public void setLogAct(String logAct) {
        this.logAct = logAct;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLogPwd() {
        return logPwd;
    }

    public void setLogPwd(String logPwd) {
        this.logPwd = logPwd;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public int getFans() {
        return fans;
    }

    public void setFans(int fans) {
        this.fans = fans;
    }

    public int getFollow() {
        return follow;
    }

    public void setFollow(int follow) {
        this.follow = follow;
    }

    public int getAcceptOrder() {
        return acceptOrder;
    }

    public void setAcceptOrder(int acceptOrder) {
        this.acceptOrder = acceptOrder;
    }

    public int getBalance() {
        return balance;
    }

    public void setBalance(int balance) {
        this.balance = balance;
    }




}