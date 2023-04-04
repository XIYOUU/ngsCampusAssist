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
    <title></title>
    <link href="AdminLTEDist/plugins/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="AdminLTEDist/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="AdminLTEDist/plugins/bootstrap/js/bootstrap.min.js"></script>

    <link rel="stylesheet" href="AdminLTEDist/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/skins/_all-skins.min.css">
    <script type="text/javascript">
        //搜集参数
        var id = $("#user_id").val();

        $(function () {
            queryAllDealTask();
        });

        function queryAllDealTask() {

            $(function () {
                $.ajax({
                    url: "student/task/queryAllDealTask.do",
                    type: 'get',
                    dataType: 'json',
                    success: function (data) {
                        //遍历接收到的数据
                        var htmlStr = "";
                        $.each(data.tasks, function (index, obj) {
                            // 当都要用"时，使用\"转义成"
                            htmlStr += "<tr class=\"text-center\">";
                            // htmlStr += "<td><input type=\"button\" style='visibility: hidden' id='task_id'   value="+obj.user.id+"></input></td>";
                            htmlStr += "<td>" + obj.brief + "</td>";
                            //1->待接取，2->被接取，3->已关闭
                            if (obj.state == 1) {
                                htmlStr += "<td style=\"color: green;\">" + "待接取" + "</td>";
                            } else if (obj.state == 2) {
                                htmlStr += "<td style=\"color: blue;\">" + "被接取" + "</td>";
                            } else if (obj.state == 3) {
                                htmlStr += "<td style=\"color:#E08E0B;\">" + "已关闭" + "</td>";
                            }
                            htmlStr += "<td>" + obj.user.name + "</td>";
                            htmlStr += "<td>" + obj.startDate + "</td>";
                            htmlStr += "<td>" + obj.endDate + "</td>";
                            htmlStr += "<td style=\"color: red;\">" + obj.cost + "</td>";
                            // if (obj.state == 1) {
                            //     htmlStr += "<td style=\"color: green;\">" + "待接取" + "</td>";
                            // } else if (obj.state == 2) {
                            //     htmlStr += "<td><button type=\"button\" class=\"btn bg-olive btn-xs\" id=\"cancel_task\">取消任务</button></td>";
                            // } else if (obj.state == 3) {
                            //     htmlStr += "<td><img src='AdminLTEDist/img/finsh.png' height=\"30px\" width=\"30px\"></img></td>";
                            // }
                            htmlStr += "</tr>";


                        });
                        $("#tBody").html(htmlStr);
                    }
                });
            });
            // //给取消按钮绑定单击事件
            // $("#tBody").on("click","button[type='button']",function(){
            //     // alert("aaa");
            //     // alert($("#tBody button[type='submit']").val());
            //     // var s=$("#tBody input").val();
            //     // console.log(s);
            //     var id=getId()
            //     alert(value);
            // });
            //
            // function getId(id) {
            //     alert(id);
            // }

        }
    </script>
</head>
<body>





<!-- 正文区域 -->
<section class="content">
    <!-- 待处理任务 -->
    <div class="box box-success">
        <div class="box-header with-border">
            <i class="fa fa-book"></i>
            <h3 class="box-title">我的任务</h3>
            <input id="user_id" type="text" value="${sessionScope.sessionUser.name}" style="visibility: hidden">
        </div>

        <div class="box-body">

            <!-- 数据表格 -->
            <div class="table-box">

                <!--数据列表-->
                <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                    <thead>
                    <tr class="text-center">
                        <%--<th class="">编号</th>--%>
                        <td class="">简介</td>
                        <td class="">状态</td>
                        <td class="">发布人</td>
                        <td class="">开始日期</td>
                        <td class="">结束日期</td>
                        <td class="">赏金</td>
                        <%--<td class="text-center">操作</td>--%>
                    </tr>
                    </thead>
                    <tbody id="tBody">
                    <%--<tr>--%>
                        <%--<td>3</td>--%>
                        <%--<td style="color: #4CAE4C;" id="item_state">待解决</td>--%>
                        <%--<!--<td>收快递</td>-->--%>
                        <%--<td>19栋楼下快递</td>--%>
                        <%--<td>--%>
                            <%--<a style="text-decoration: none; cursor: pointer;"--%>
                               <%--onclick="window.location.href='detail.html';">张三</a>--%>
                        <%--</td>--%>
                        <%--<td>2022-10-10</td>--%>
                        <%--<td>2022-12-20</td>--%>
                        <%--<td style="color: red;">5</td>--%>
                        <%--<td>--%>
                            <%--<button type="button" class="btn bg-olive btn-xs">编辑</button>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td>1</td>--%>
                        <%--<td>张三</td>--%>
                        <%--<td>19栋楼下快递</td>--%>
                        <%--<td>2022-03-07 17:45</td>--%>
                        <%--<td>2023-01-05 17:45</td>--%>
                        <%--<td class="text-center">--%>
                            <%--<button type="button" class="btn bg-olive btn-xs">编辑</button>--%>
                        <%--</td>--%>
                    <%--</tr>--%>

                    <%--<tr>--%>
                        <%--<td></td>--%>
                        <%--<td>张三</td>--%>
                        <%--<td>19栋楼下快递</td>--%>
                        <%--<td>2022-03-07 17:45</td>--%>
                        <%--<td>2023-01-05 17:45</td>--%>
                        <%--<td class="text-center">--%>
                            <%--<button type="button" class="btn bg-olive btn-xs">编辑</button>--%>
                        <%--</td>--%>
                    <%--</tr>--%>

                    </tbody>
                </table>
                <!--数据列表/-->

            </div>
            <!-- 数据表格 /-->

        </div>
        <!-- /.box-body -->

    </div>
    <!-- 待处理游记 /-->
</section>
</body>
</html>
