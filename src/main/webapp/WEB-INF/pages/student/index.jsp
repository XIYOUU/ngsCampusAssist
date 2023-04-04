<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--动态的协议 ip 端口 工作目录--%>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>

<head>

    <base href="<%=basePath%>">
    <meta charset="UTF-8">
    <link href="AdminLTEDist/plugins/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="AdminLTEDist/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="AdminLTEDist/plugins/bootstrap/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="AdminLTEDist/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/skins/_all-skins.min.css">
    <script src="AdminLTEDist/plugins/adminLTE/js/app.min.js"></script>

    <script type="text/javascript">
        //页面加载完毕
        $(function () {
            //打开工作区页面
            window.open("student/platform_index/index.do", "workareaFrame");
            //给确定按钮添加单击事件
            $("#logoutBtn").click(function () {
                //发送同步请求
                //alert("ddd");
                window.location.href = "settings/qx/user/logout.do";
            });
        });
    </script>

</head>

<body class="hold-transition skin-blue sidebar-mini">

<!-- 退出系统的模态窗口 -->
<div class="modal fade" id="exitModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">离开</h4>
            </div>
            <div class="modal-body">
                <p>您确定要退出系统吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal"
                        onclick="window.location.href='../settings/qx/user/login.jsp';">确定
                </button>
            </div>
        </div>
    </div>
</div>

<div class="wrapper">
    <!-- 页面头部 -->
    <header class="main-header">

        <!-- Logo -->
        <a href="all-admin-index.html" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>平台</b></span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>校园帮</b>平台管理</span>
        </a>

        <!-- Header Navbar: style can be found in header.less 缩小面板-->
        <nav class="navbar navbar-static-top">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <!--名字-->
                    <!--<div style="position: absolute; top: 15px; right: 15px; border: 1px solid red">-->
                    <!--<ul>-->
                    <li class="dropdown user user-dropdown">
                        <a href="javascript:void(0)" style="text-decoration: none; color: white;"
                           class="dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-user"></span> ${sessionScope.sessionUser.name} <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">

                            <li>
                                <a id="logoutBtn" href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span
                                        class="glyphicon glyphicon-off"></span> 退出</a>
                            </li>

                        </ul>
                    </li>
                    <!--</ul>-->
                    <!--</div>-->
                </ul>
            </div>
        </nav>

    </header>
    <!-- 页面头部 /-->

    <!-- 导航侧栏 -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">

            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">

                <li class="liClass">
                    <a href="student/platform_index/index.do" target="workareaFrame"><span
                            class="glyphicon glyphicon-home"></span>首页</a>
                </li>
                <li class="liClass">
                    <a href="#no2" class="collapsed" data-toggle="collapse"><span
                            class="glyphicon glyphicon-stats"></span> 任务管理</a>
                    <ul id="no2" class="nav nav-pills nav-stacked collapse">
                        <li class="liClass">
                            <a href="student/task/deal.do" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
                                    class="glyphicon glyphicon-chevron-right"></span> 我的任务</a>
                        </li>
                        <li class="liClass">
                            <a href="student/task/save.do" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
                                    class="glyphicon glyphicon-chevron-right"></span> 发布任务</a>
                        </li>

                    </ul>
                </li>
                <li class="liClass">
                    <a href="#no3" class="collapsed" data-toggle="collapse"><span
                            class="glyphicon glyphicon-stats"></span> 个人中心</a>
                    <ul id="no3" class="nav nav-pills nav-stacked collapse">
                        <li class="liClass">
                            <a href="student/user/user_info.do" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span
                                    class="glyphicon glyphicon-chevron-right"></span> 个人信息</a>
                        </li>
                    </ul>
                </li>
                <%--<li class="liClass">--%>
                    <%--<a href="#no4" class="collapsed" data-toggle="collapse"><span--%>
                            <%--class="glyphicon glyphicon-stats"></span> 评价管理</a>--%>
                    <%--<ul id="no4" class="nav nav-pills nav-stacked collapse">--%>
                        <%--<li class="liClass">--%>
                            <%--<a href="chart/activity/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span--%>
                                    <%--class="glyphicon glyphicon-chevron-right"></span> 我的评价</a>--%>
                        <%--</li>--%>
                        <%--<li class="liClass">--%>
                            <%--<a href="chart/clue/index.html" target="workareaFrame">&nbsp;&nbsp;&nbsp;<span--%>
                                    <%--class="glyphicon glyphicon-chevron-right"></span> 评价我的</a>--%>
                        <%--</li>--%>
                    <%--</ul>--%>
                <%--</li>--%>

            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>
    <!-- 导航侧栏 /-->

    <!-- 内容区域 -->
    <div class="content-wrapper" style=" width: 100%; height: 100%; position: relative;">

        <div id="workarea" style="position: absolute;width: 100%; height: 100%;">
            <iframe style="position: absolute; border-width: 0px; width: 86.5%; height: 100%;"
                    name="workareaFrame"></iframe>

        </div>

    </div>
    <!-- 内容区域 /-->

    <!-- 底部导航 -->
    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>Design</b> by 15
        </div>
        <strong>Copyright &copy; 2022 <a href="http://www.itcast.cn">20软件java3班</a>.</strong>
    </footer>
    <!-- 底部导航 /-->
</div>
</body>

</html>