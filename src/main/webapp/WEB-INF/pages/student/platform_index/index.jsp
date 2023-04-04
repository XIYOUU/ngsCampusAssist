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

    <!--  分页插件  -->
    <link rel="stylesheet" type="text/css"
          href="AdminLTEDist/plugins/bs_pagination-master/css/jquery.bs_pagination.min.css">
    <script type="text/javascript"
            src="AdminLTEDist/plugins/bs_pagination-master/js/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript" src="AdminLTEDist/plugins/bs_pagination-master/localization/en.js"></script>
    <script type="text/javascript">
        $(function () {

            //页面加载完成之后显示所有的任务
            queryTaskByConditionForPage(1, 10);


            /**查询模块*/
            //给"查询"按钮添加单击事件
            $("#queryTaskBtn").click(function () {
                //查询所有符合条件数据的第一页以及所有符合条件数据的总条数;
                queryTaskByConditionForPage(1, $("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'));
            });


            $("#receiveBtn").click(function(){
                //搜集参数
                var chekkedIds=$("#tBody input[type='checkbox']:checked");
                // alert(chekkedIds);
                if(chekkedIds.size()==0){
                    alert("请选择要接取的任务");
                    return;
                }
                //拼接数据
                var ids=[];
                $.each(chekkedIds,function () {//id=xxxx&id=xxx&.....&id=xxx&
                    ids.push(this.value);
                });
                console.log(ids);
                // alert(ids);
                //发送请求
                $.ajax({
                    url:'student/task/updateDealTaskByIds.do',
                    data:{
                        ids:ids.toString()
                    },
                    type:'post',
                    dataType:'json',
                    success:function (data) {
                        //关闭接取任务对话框
                        $("#receiveTaskModal").modal("hide");
                        //刷新页面
                        if(data.code=="1"){
                            //刷新市场活动列表,显示第一页数据,保持每页显示条数不变
                            queryTaskByConditionForPage(1,$("#demo_pag1").bs_pagination('getOption', 'rowsPerPage'));
                        }else{
                            //提示信息
                            alert(data.message);
                        }
                    }
                });


            })
        });


        //根据页号和页数分页查询
        function queryTaskByConditionForPage(pageNo, pageSize) {
            var brief = $("#query-name").val();
            // console.log($("#query-name").val());
            $.ajax({
                url: "student/platform_index/queryByConditionForPage.do",
                data: {
                    brief: brief,
                    pageNo: pageNo,
                    pageSize: pageSize
                },
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    //遍历接收到的数据
                    var htmlStr = "";
                    var user_name=$("#user_name").val();
                    //jQeury的遍历针对js数据
                    //jstl，el表达式遍历用在作用域里
                    // alert(user_name);
                    $.each(data.tasks, function (index, obj) {
                        // 当都要用"时，使用\"转义成"
                        htmlStr += "<tr class=\"text-center\">";
                        //如果state不是待接取（1）或者是自己的任务，则复选框变灰
                        if(obj.state != 1){
                            htmlStr += "<td><input type=\"checkbox\" disabled=true/></td>";
                        }else if(obj.user.name==user_name){
                            htmlStr += "<td><input type=\"checkbox\" disabled=true/></td>";
                        }else {
                            htmlStr += "<td><input type=\"checkbox\" value=\"" + obj.id + "\"/></td>";
                        }
                        htmlStr += "<td>" + obj.brief + "</td>";
                        //1->待接取，2->被接取，3->已关闭
                        if (obj.state == 1) {
                            htmlStr += "<td style=\"color: green;\">" + "待接取" + "</td>";
                        } else if (obj.state == 2) {
                            htmlStr += "<td style=\"color: blue;\">" + "被接取" + "</td>";
                        } else if (obj.state == 3) {
                            htmlStr += "<td style=\"color:#E08E0B;\">" + "已关闭" + "</td>";
                        }
                        htmlStr += "<td>" + obj.user.name +  "</td>";
                        htmlStr += "<td>" + obj.startDate + "</td>";
                        htmlStr += "<td>" + obj.endDate + "</td>";
                        htmlStr += "<td style=\"color: red;\">" + obj.cost + "</td>";
                        htmlStr += "</tr>";
                    });
                    $("#tBody").html(htmlStr);
                    // alert($(""))
                    //计算总页数
                    var totalPages = 1;
                    if (data.totalRows % pageSize == 0) {
                        totalPages = data.totalRows / pageSize;
                    } else {
                        totalPages = parseInt(data.totalRows / pageSize) + 1;
                    }
                    // alert(totalPages);
                    //对容器调用bs_pagination工具函数，显示翻页信息
                    $("#demo_pag1").bs_pagination({
                        currentPage: pageNo,//当前页号,相当于pageNo

                        rowsPerPage: pageSize,//每页显示条数,相当于pageSize
                        totalRows: data.totalRows,//总条数
                        totalPages: totalPages,  //总页数,必填参数.

                        visiblePageLinks: 5,//最多可以显示的卡片数

                        showGoToPage: true,//是否显示"跳转到"部分,默认true--显示
                        showRowsPerPage: true,//是否显示"每页显示条数"部分。默认true--显示
                        showRowsInfo: true,//是否显示记录的信息，默认true--显示

                        //用户每次切换页号，都自动触发本函数;
                        //每次返回切换页号之后的pageNo和pageSize
                        onChangePage: function (event, pageObj) { // returns page_num and rows_per_page after a link has clicked
                            //js代码
                            //alert(pageObj.currentPage);
                            //alert(pageObj.rowsPerPage);
                            queryTaskByConditionForPage(pageObj.currentPage, pageObj.rowsPerPage);
                        }
                    });


                }
            })
        }

    </script>

    <style>
        <%--对话框--%>
        .example-modal .modal {
            position: relative;
            top: auto;
            bottom: auto;
            right: auto;
            left: auto;
            display: block;
            z-index: 1;
            height: 280px;
        }

        .example-modal .modal {
            background: transparent !important;
        }
    </style>
</head>

<body>
<!-- 接取对话框模态窗口 -->
<div class="modal fade" id="receiveTaskModal" role="dialog">
    <div class="example-modal">
        <div class="modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">确定接取？</h4>
                    </div>
                    <%--<div class="modal-body">--%>
                        <%--<p></p>--%>
                    <%--</div>--%>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default pull-left" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="receiveBtn">接取</button>
                    </div>
                </div>
                <!-- /.modal-content -->
            </div>
            <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
    </div>
    <!-- /.example-modal -->
</div>

<!-- 正文区域 -->
<section class="content">

    <!-- 待处理订单 -->
    <div class="box box-primary">
        <div class="box-header with-border">
            <i class="fa fa-cube"></i>
            <h3 class="box-title">任务列表</h3>
        </div>

        <!--搜索框+新增按钮-->
        <div style="position: relative; top: 20px; left: 0px; width: 100%;height: 80px;">
            <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
                <div class="btn-toolbar" role="toolbar" style="height: 80px;">
                    <form class="form-inline" role="form"
                          style="position: relative;top: 8%; left: 5px; margin-left: 5px;">
                        <div class="form-group">
                            <div class="input-group">
                                <div class="input-group-addon">简介</div>
                                <input class="form-control" type="text" id="query-name">
                            </div>
                            <button type="button" class="btn btn-github" id="queryTaskBtn">查询</button>

                            <button type="button" class="btn btn-google" id="createTaskBtn" data-toggle="modal" data-target="#receiveTaskModal"
                                    style="margin-left: 50px;">
                                <span class=""></span> 接取
                            </button>
                            <input id="user_name" type="text" value="${sessionScope.sessionUser.name}" style="visibility: hidden">
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="box-body">

            <!-- 数据表格 -->
            <div class="table-box">

                <!--数据列表-->
                <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
                    <thead>
                    <tr style="color: #B3B3B3;" height="40px" class="text-center">
                        <td class="">多选
                        </th>
                        <td class="">简介</td>
                        <td class="">状态</td>
                        <!--灰色->已关闭,绿色->待解决，蓝色->被接取-->
                        <td class="">发布人</td>
                        <td class="">开始日期</td>
                        <td class="">结束日期</td>
                        <td class="">赏金</td>
                    </tr>
                    </thead>
                    <tbody id="tBody">
                    <tr class="text-center">
                        <td><input type="checkbox"/></td>
                        <td>19栋楼下快递</td>
                        <td style="color: #4CAE4C;" id="item_state">待解决</td>
                        <td>
                            <a style="text-decoration: none; cursor: pointer;"
                               onclick="window.location.href='detail.html';">张三</a>
                        </td>
                        <td>2022-10-10</td>
                        <td>2022-12-20</td>
                        <td style="color: red;">5</td>
                    </tr>

                    <tr class="text-center">
                        <td><input type="checkbox"/></td>
                        <td>19栋楼下快递</td>
                        <td style="color: #4CAE4C;" id="item_state2">待解决</td>
                        <td>
                            <a style="text-decoration: none; cursor: pointer;"
                               onclick="window.location.href='detail.html';">张三</a>
                        </td>
                        <td>2022-10-10</td>
                        <td>2022-12-20</td>
                        <td style="color: red;">5</td>
                    </tr>

                    <tr class="text-center">
                        <td><input type="checkbox"/></td>
                        <td>19栋楼下快递</td>
                        <td style="color: #4CAE4C;" id="item_state1">待解决</td>
                        <td>
                            <a style="text-decoration: none; cursor: pointer;"
                               onclick="window.location.href='detail.html';">张三</a>
                        </td>
                        <td>2022-10-10</td>
                        <td>2022-12-20</td>
                        <td style="color: red;">5</td>
                    </tr>

                    </tbody>
                </table>
                <!--数据列表/-->
                <%--分页--%>
                <div id="demo_pag1"></div>
                <%--分页--%>
            </div>
            <!-- 数据表格 /-->


        </div>
        <!-- /.box-body -->


    </div>
    <!-- 待处理订单 /-->

</section>
</body>

</html>