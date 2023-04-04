<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--动态的协议 ip 端口 工作目录--%>
<%
    String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <link href="AdminLTEDist/plugins/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="AdminLTEDist/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="AdminLTEDist/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        // $(function () {
        //     alert("aaa");
        // })
        $(function () {
            //给整个浏览器窗口添加键盘按下事件
            $(window).keydown(function (e) {
                if(e.keyCode==13){
                    //无参表示模拟一次发生事件
                    $("#loginBtn").click();
                }
            });

            //给登录按钮添加单击事件
            //有参表示给事件绑定方法
            $("#loginBtn").click(function(){
                //console.log("点击了");
                //收集参数
                var loginAct=$("#loginAct").val();
                var loginPwd=$("#loginPwd").val();
                var isRemPwd=$("#isRemPwd").prop("checked");
                //表单验证
                //return false之后就不跳转，这是为什么呢？直接return不行？
                if(loginAct==""){
                    alert("用户名不能为空");
                    return false;
                }
                if(loginPwd==""){
                    alert("密码不能为空");
                    return false;
                }
                if(loginPwd==""){
                    alert("密码不能为空");
                    return false;
                }
                //发送请求
                $.ajax({
                    url:'settings/qx/user/login.do',
                    data:{
                        loginAct: loginAct,
                        loginPwd: loginPwd,
                        isRemPwd: isRemPwd
                    },
                    type: 'post',
                    dataType: 'json',
                    success:function (data) {
                        if(data.code=="1"){
                            //跳转到业务主页面
                            window.location.href="student/index.do";
                        }else{
                            //提示信息
                            $("#msg").html(data.message);
                            alert("用户名或密码错误");
                            return false;
                        }
                    },
                    beforeSend:function(){
                        //提示正在验证
                        $("#msg").html("正在努力验证......");
                        return true;
                    }
                })
            });
        });
    </script>
</head>

<body>
<div style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%;">
    <img src="AdminLTEDist/img/index.png" style="width: 100%; height: 100%; position: relative;display: block;">

    <!--<div style="position:relative;height: 100%;width: 100%;">-->
    <div style="background-color: white; position: absolute;top: 0;left: 0;right: 0;bottom: 0;margin-left: 65%; margin-top: 12%; height: 380px; width: 420px;">
        <div class="page-header">

            <h1 style="text-align: center;">校园帮</h1>
        </div>
        <%--<form action="../../../student/index.jsp" class="form-horizontal" role="form" style="margin-left: 50px;">--%>
        <div class="form-group form-group-lg" style="margin-left: 38px;">
            <div style="width: 350px;">
                <input id="loginAct" class="form-control" type="text" value="${cookie.loginAct.value}" placeholder=" 用户名">
            </div>
            <div style="width: 350px; position: relative;top: 20px;">
                <input id="loginPwd" class="form-control" type="password" value="${cookie.loginPwd.value}" placeholder=" 密码">
            </div>
            <div class="checkbox" style="position: relative;top: 30px; left: 10px;">
                <label>
                    <c:if test="${not empty cookie.loginAct and not empty cookie.loginPwd}">
                        <input type="checkbox" id="isRemPwd" checked>
                    </c:if>
                    <c:if test="${empty cookie.loginAct or empty cookie.loginPwd}">
                        <input type="checkbox" id="isRemPwd">
                    </c:if>
                    十天内免登录
                </label> &nbsp;&nbsp;
                <span id="msg"></span>
            </div>
            <button id="loginBtn" type="botton" class="btn btn-primary btn-lg btn-block"
                    style="width: 350px; position: relative;top: 45px;">登录
            </button>
        </div>
        <%--</form>--%>
        <!--</div>-->
    </div>
</div>
</body>

</html>