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
    <link rel="stylesheet" type="text/css" href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" href="AdminLTEDist/plugins/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/skins/_all-skins.min.css">

    <script type="text/javascript" src="AdminLTEDist/plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script type="text/javascript" src="AdminLTEDist/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>


    <script>
        $(function(){
            queryAllSaveTask();
            //给"发布"按钮添加单击事件
            $("#createTaskBtn").click(function () {
                //清空数据
                $("#create_task_form").get(0).reset();

                $("#createTaskModal").modal("show");
            });

            //当容器加载完成之后，对容器调用工具函数
            //$("input[name='mydate']").datetimepicker({
            $(".mydate").datetimepicker({
                language: 'zh-CN', //语言
                format: 'yyyy-mm-dd hh:ii',//日期的格式
                minView: '0', //可以选择的最小视图
                initialDate: new Date(),//初始化显示的日期
                autoclose: true,//设置选择完日期或者时间之后，日否自动关闭日历
                todayBtn: true,//设置是否显示"今天"按钮,默认是false
                clearBtn: true//设置是否显示"清空"按钮，默认是false
            });

            //给模态窗口"发布"添加单击事件
            $("#create_task_btn").click(function () {
                //搜集参数
                var brief = $("#brief").val();
                var startDate = $("#start_date").val();
                var endDate = $("#end_date").val();
                var cost = $("#cost").val();
                //数据为空提醒用户
                if(brief==""){
                    alert("简介不能为空");
                    return ;
                }
                if(startDate==""){
                    alert("开始日期不能为空");
                    return ;
                }
                if(endDate==""){
                    alert("结束日期不能为空");
                    return ;
                }
                if(cost==""){
                    alert("赏金不能为空");
                    return ;
                }
                if (startDate != "" && endDate != "") {
                    //使用字符串的大小代替日期的大小
                    if (endDate < startDate) {
                        alert("结束日期不能比开始日期小");
                        return;
                    }
                }
                $.ajax({
                    url: "student/task/insertTask.do",
                    data: {
                        brief: brief,
                        startDate: startDate,
                        endDate: endDate,
                        cost:cost
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        //关闭接取任务对话框
                        $("#createTaskModal").modal("hide");
                        //刷新页面
                        if(data.code=="1"){
                            // //刷新任务列表
                            queryAllSaveTask();
                            // alert("aaaa");
                        }else{
                            //提示信息
                            alert(data.message);
                        }
                    }
                })
            });

            //给"删除"按钮添加单击事件
            $("#deleteTaskBtn").click(function () {
                //收集参数
                //获取列表中所有被选中的checkbox
                var chekkedIds=$("#tBody input[type='checkbox']:checked");
                if(chekkedIds.size()==0){
                    alert("请选择要删除的任务");
                    return;
                }

                if(window.confirm("确定删除吗？")){
                    var ids="";
                    $.each(chekkedIds,function () {//id=xxxx&id=xxx&.....&id=xxx&
                        ids+="id="+this.value+"&";
                    });
                    ids=ids.substr(0,ids.length-1);//id=xxxx&id=xxx&.....&id=xxx

                    //发送请求
                    $.ajax({
                        url:'student/task//deleteTaskByIds.do',
                        data:ids,
                        type:'post',
                        dataType:'json',
                        success:function (data) {
                            if(data.code=="1"){
                                //刷新市场活动列表,显示第一页数据,保持每页显示条数不变
                                queryAllSaveTask();
                            }else{
                                //提示信息
                                alert(data.message);
                            }
                        }
                    });
                }
            });

            //给"修改"按钮添加单击事件
            $("#editTaskBtn").click(function () {

                //收集参数
                //获取列表中被选中的checkbox
                var checkIds=$("#tBody input[type='checkbox']:checked");
                if(checkIds.size()==0){
                    alert("请选择要修改的任务");
                    return;
                }
                if(checkIds.size()>1){
                    alert("每次只能修改一个任务");
                    return;
                }
                var id=checkIds[0].value;
                //发送请求
                $.ajax({
                    url:"student/task/queryTaskById.do",
                    data:{id:id},
                    type:'get',
                    dataType:'json',
                    success:function (data) {
                        //把市场活动的信息显示在修改的模态窗口上
                        $("#edit_id").val(data.id);
                        $("#edit_brief").val(data.brief);
                        $("#edit_start_date").val(data.startDate);
                        $("#edit_end_date").val(data.endDate);
                        $("#edit_cost").val(data.cost);
                        //弹出模态窗口
                        $("#editTaskModal").modal("show");
                    }

                })
            })
            //给修改模态窗口"保存"按钮添加单击事件

            $("#edit_task_btn").click(function () {
                //收集参数
                var id=$("#edit_id").val();
                var brief=$("#edit_brief").val();
                var startDate=$("#edit_start_date").val();
                var endDate=$("#edit_end_date").val();
                var cost=$("#edit_cost").val();
                //表单验证(作业)

                //发送请求
                $.ajax({
                    url:'student/task/saveEditTask.do',
                    data:{
                        id:id,
                        brief:brief,
                        startDate:startDate,
                        endDate:endDate,
                        cost:cost,
                    },
                    type:'post',
                    dataType:'json',
                    success:function (data) {
                        if(data.code=="1"){
                            //关闭模态窗口
                            $("#editTaskModal").modal("hide");
                            //刷新市场活动列表,保持页号和每页显示条数都不变
                            queryAllSaveTask();
                        }else{
                            //提示信息
                            alert(data.message);
                            //模态窗口不关闭
                            $("#editActivityModal").modal("show");
                        }
                    }
                });
            })

            //给"完成"按钮添加单击事件
            $("#finshTaskBtn").click(function () {
                //收集参数
                //获取列表中所有被选中的checkbox
                var chekkedIds=$("#tBody input[type='checkbox']:checked");
                if(chekkedIds.size()==0){
                    alert("请选择要完成的任务");
                    return;
                }

                if(window.confirm("确定完成了吗？")){
                    var ids="";
                    $.each(chekkedIds,function () {//id=xxxx&id=xxx&.....&id=xxx&
                        ids+="id="+this.value+"&";
                    });
                    ids=ids.substr(0,ids.length-1);//id=xxxx&id=xxx&.....&id=xxx

                    //发送请求
                    $.ajax({
                        url:'student/task/finshTaskByIds.do',
                        data:ids,
                        type:'post',
                        dataType:'json',
                        success:function (data) {
                            if(data.code=="1"){
                                //刷新市场活动列表,显示第一页数据,保持每页显示条数不变
                                queryAllSaveTask();
                            }else{
                                //提示信息
                                alert(data.message);
                            }
                        }
                    });
                }
            });
        });


        function queryAllSaveTask() {

            $(function () {
                $.ajax({
                    url: "student/task/queryAllSaveTask.do",
                    type: 'get',
                    dataType: 'json',
                    success: function (data) {
                        //遍历接收到的数据
                        var htmlStr = "";
                        $.each(data.tasks, function (index, obj) {
                            // 当都要用"时，使用\"转义成"
                            htmlStr += "<tr class=\"text-center\">";
                            if (obj.state == 1) {
                                htmlStr += "<td><input type=\"checkbox\" value=\"" + obj.id + "\"/></td>";
                            } else if (obj.state == 2) {
                                htmlStr += "<td><input type=\"checkbox\" value=\"" + obj.id + "\"/></td>";
                            } else if (obj.state == 3) {
                                htmlStr += "<td><img src='AdminLTEDist/img/finsh.png' height=\"20px\" width=\"20px\"></img></td>";
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
                            // htmlStr += "<td>" + obj.user.name + "</td>";
                            htmlStr += "<td>" + obj.startDate + "</td>";
                            htmlStr += "<td>" + obj.endDate + "</td>";
                            htmlStr += "<td style=\"color: red;\">" + obj.cost + "</td>";
                            htmlStr += "</tr>";


                        });
                        $("#tBody").html(htmlStr);
                    }
                });
            });
        }
    </script>
</head>

<body>

<!-- 创建任务的模态窗口 -->
<div class="modal fade" id="createTaskModal" role="dialog" style="top: -20%">
    <div class="modal-dialog" role="document" style="width: 85%;">\
        <div class="modal-content">
        <!-- right column -->
        <div class="col-md-12">
            <!-- Horizontal Form -->
            <div class="box box-info">
                <div class="box-header with-border">
                    <h3 class="box-title">创建任务</h3>
                </div>
                <!-- /.box-header -->
                <!-- form start -->
                <form class="form-horizontal" id="create_task_form">
                    <div class="box-body">
                        <div class="form-group">
                            <span style="font-size: 15px; color: red;">*</span></label><label for="brief" class="col-sm-2 control-label">简介</label>

                            <div class="col-sm-10">
                                <textarea type="text" class="form-control" id="brief" placeholder="简介"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <span style="font-size: 15px; color: red;">*</span></label><label for="start_date" class="col-sm-2 control-label" >开始时间</label>

                            <div class="col-sm-10">
                                <input type="text" class="form-control mydate" name="mydate" readonly id="start_date" placeholder="开始时间">
                            </div>
                        </div>
                        <div class="form-group">
                            <span style="font-size: 15px; color: red;">*</span></label><label for="end_date" class="col-sm-2 control-label">结束时间</label>

                            <div class="col-sm-10">
                                <input type="text" class="form-control mydate" name="mydate" readonly id="end_date" placeholder="结束时间">
                            </div>
                        </div>

                        <div class="form-group">
                            <span style="font-size: 15px; color: red;">*</span></label><label for="cost" class="col-sm-2 control-label">赏金</label>

                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="cost" placeholder="赏金">
                            </div>
                        </div>

                    </div>
                    <!-- /.box-body -->
                    <div class="box-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-info pull-right" id="create_task_btn">发布</button>
                    </div>
                </form>

                <!-- /.box-footer -->
            </div>
        </div>
        <!--/.col (right) -->
        </div>
    </div>
</div>


<!-- 修改任务的模态窗口 -->
<div class="modal fade" id="editTaskModal" role="dialog" style="top: -20%">
    <div class="modal-dialog" role="document" style="width: 85%;">\
        <div class="modal-content">
            <!-- right column -->
            <div class="col-md-12">
                <!-- Horizontal Form -->
                <div class="box box-info">
                    <div class="box-header with-border">
                        <h3 class="box-title">创建任务</h3>
                    </div>
                    <!-- /.box-header -->
                    <!-- form start -->
                    <form class="form-horizontal" id="edit_task_form">
                        <div class="box-body">
                            <input type="hidden" id="edit_id">
                            <div class="form-group">
                                <label for="edit_brief" class="col-sm-2 control-label">简介</label>

                                <div class="col-sm-10">
                                    <textarea type="text" class="form-control" id="edit_brief" placeholder="简介"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="edit_start_date" class="col-sm-2 control-label" >开始时间</label>

                                <div class="col-sm-10">
                                    <input type="text" class="form-control mydate" name="mydate" readonly id="edit_start_date" placeholder="开始时间">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="edit_end_date" class="col-sm-2 control-label">结束时间</label>

                                <div class="col-sm-10">
                                    <input type="text" class="form-control mydate" name="mydate" readonly id="edit_end_date" placeholder="结束时间">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="edit_cost" class="col-sm-2 control-label">赏金</label>

                                <div class="col-sm-10">
                                    <input type="text" class="form-control" id="edit_cost" placeholder="赏金">
                                </div>
                            </div>

                        </div>
                        <!-- /.box-body -->
                        <div class="box-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-info pull-right" id="edit_task_btn">保存</button>
                        </div>
                    </form>

                    <!-- /.box-footer -->
                </div>
            </div>
            <!--/.col (right) -->
        </div>
    </div>
</div>

<!-- 正文区域 -->
<section class="content">

    <!-- 待处理订单 -->
    <div class="box box-primary">
        <div class="box-header with-border">
            <i class="fa fa-cube"></i>
            <h3 class="box-title">发布任务</h3>
        </div>


        <!--搜索框+新增按钮-->
        <div style="position: relative; top: 20px; left: 0px; width: 100%;height: 80px;">
            <div style="width: 100%; position: absolute;top: 5px; left: 10px;">
                <div class="btn-toolbar" role="toolbar" style="height: 80px;">
                    <form class="form-inline" role="form"
                          style="position: relative;top: 8%; left: 5px; margin-left: 5px;">
                        <div class="form-group">
                            <%--<div class="input-group">--%>
                                <%--<div class="input-group-addon">简介</div>--%>
                                <%--<input class="form-control" type="text" id="query-name">--%>
                            <%--</div>--%>
                            <%--<button type="button" class="btn btn-github" id="queryActivityBtn">查询</button>--%>



                            <div class="btn-group" style="position: relative; top: 18%;">
                                <button type="button" class="btn btn-default" id="createTaskBtn"
                                        style="margin-left: 10px;">
                                    <span class="" ></span> 发布
                                </button>
                                <%--<button type="button" class="btn btn-primary" id="createActivityBtn"><span--%>
                                        <%--class="glyphicon glyphicon-plus"></span> 创建--%>
                                <%--</button>--%>
                                <button type="button" class="btn btn-twitter" id="editTaskBtn" style="margin-left: 20px"><span
                                        class=""></span> 修改
                                </button>
                                <button type="button" class="btn btn-danger" id="deleteTaskBtn" style="margin-left: 20px"><span class=""></span> 删除</button>
                                <button type="button" class="btn btn-info" id="finshTaskBtn" style="margin-left: 20px"><span class=""></span> 完成</button>
                            </div>
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
                        <td class="">
                        </th>
                        <td class="">简介</td>
                        <td class="">状态</td>
                        <!--灰色->已关闭,绿色->待解决，蓝色->被接取-->
                        <%--<td class="">接取人</td>--%>
                        <td class="">开始日期</td>
                        <td class="">结束日期</td>
                        <td class="">赏金</td>
                    </tr>
                    </thead>
                    <tbody id="tBody">
                    <%--<tr class="text-center">--%>
                        <%--<td><input type="checkbox"/></td>--%>
                        <%--<td>19栋楼下快递</td>--%>
                        <%--<td style="color: #0000FF;" id="item_state">被接取</td>--%>
                        <%--<td>--%>
                            <%--<a style="text-decoration: none; cursor: pointer;"--%>
                               <%--onclick="window.location.href='detail.html';">李四</a>--%>
                        <%--</td>--%>
                        <%--<td>2022-10-10</td>--%>
                        <%--<td>2022-12-20</td>--%>
                        <%--<td style="color: red;">5</td>--%>
                    <%--</tr>--%>

                    <%--<tr class="text-center">--%>
                        <%--<td><input type="checkbox"/></td>--%>
                        <%--<td>19栋楼下快递</td>--%>
                        <%--<td style="color: #0000FF;" id="item_state2">被接取</td>--%>
                        <%--<td>--%>
                            <%--<a style="text-decoration: none; cursor: pointer;"--%>
                               <%--onclick="window.location.href='detail.html';">王五</a>--%>
                        <%--</td>--%>
                        <%--<td>2022-10-10</td>--%>
                        <%--<td>2022-12-20</td>--%>
                        <%--<td style="color: red;">5</td>--%>
                    <%--</tr>--%>

                    <%--<tr class="text-center">--%>
                        <%--<td><input type="checkbox"/></td>--%>
                        <%--<td>19栋楼下快递</td>--%>
                        <%--<td style="color: #4CAE4C;" id="item_state1">待解决</td>--%>
                        <%--<td>--%>
                            <%--<a style="text-decoration: none; cursor: pointer;"--%>
                               <%--onclick="window.location.href='detail.html';"></a>--%>
                        <%--</td>--%>
                        <%--<td>2022-10-10</td>--%>
                        <%--<td>2022-12-20</td>--%>
                        <%--<td style="color: red;">5</td>--%>
                    <%--</tr>--%>

                    </tbody>
                </table>
                <!--数据列表/-->

            </div>
            <!-- 数据表格 /-->
        </div>
    </div>
    <!-- 待处理订单 /-->

</section>

</body>

</html>