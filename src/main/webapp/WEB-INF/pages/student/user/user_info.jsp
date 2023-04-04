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
		<link href="AdminLTEDist/plugins/bootstrap/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
		<script type="text/javascript" src="AdminLTEDist/plugins/jQuery/jquery-2.2.3.min.js"></script>
		<script type="text/javascript" src="AdminLTEDist/plugins/bootstrap/js/bootstrap.min.js"></script>


		<link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/AdminLTE.css">
		<link rel="stylesheet" href="AdminLTEDist/plugins/adminLTE/css/skins/_all-skins.min.css">
		
		<script src="AdminLTEDist/plugins/chartjs/Chart.min.js"></script>
		<script src="AdminLTEDist/plugins/flot/jquery.flot.min.js"></script>
		<script src="AdminLTEDist/plugins/flot/jquery.flot.resize.min.js"></script>
		<script src="AdminLTEDist/plugins/flot/jquery.flot.pie.min.js"></script>
		<script src="AdminLTEDist/plugins/flot/jquery.flot.categories.min.js"></script>
	</head>

	<body>
		<!-- Content Wrapper. Contains page content -->
		<div class="">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
            个人信息
        </h1>
				<!--<ol class="breadcrumb">
					<li>
						<a href="#"><i class="fa fa-dashboard"></i> Home</a>
					</li>
					<li>
						<a href="#">Examples</a>
					</li>
					<li class="active">User profile</li>
				</ol>-->
			</section>

			<!-- Main content -->
			<section class="content">

				<div class="row">
					<div class="col-md-3">

						<!-- Profile Image -->
						<div class="box box-primary">
							<div class="box-body box-profile">
								<!--<img class="profile-user-img img-responsive img-circle" src="AdminLTEDist/img/avatar.png" alt="User profile picture">-->

								<h3 class="profile-username text-center">张三</h3>

								<p class="text-muted text-center">软件技术Java3班</p>

								<ul class="list-group list-group-unbordered">
									<li class="list-group-item">
										<b>粉丝</b>
										<a class="pull-right">66</a>
									</li>
									<li class="list-group-item">
										<b>关注</b>
										<a class="pull-right">12</a>
									</li>
									<li class="list-group-item">
										<b>总接单量</b>
										<a class="pull-right">231</a>
									</li>
									<li class="list-group-item">
										<b>余额</b>
										<a class="pull-right">561</a>
									</li>
								</ul>

								<!--<a href="#" class="btn btn-primary btn-block"><b>点击关注</b></a>-->
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->

						<!-- About Me Box -->
						<div class="box box-primary">
							<div class="box-header with-border">
								<h3 class="box-title">关于我</h3>
							</div>
							<!-- /.box-header -->
							<div class="box-body">
								<strong><i class="fa fa-book margin-r-5"></i> 兴趣爱好</strong>

								<p class="text-muted">
									唱、跳、rap、篮球
								</p>

								<hr>

								<strong><i class="fa fa-map-marker margin-r-5"></i> 属地</strong>

								<p class="text-muted">广东惠东</p>

								<hr>

								<strong><i class="fa fa-pencil margin-r-5"></i> 业务特长</strong>

								<p>
									<span class="label label-danger">写字好看</span>
									<span class="label label-success">专业技术过硬</span>
									<span class="label label-info">专业解答</span>
									<span class="label label-warning">人脉广</span>
									<span class="label label-primary">火速送达</span>
								</p>

								<hr>

								<strong><i class="fa fa-file-text-o margin-r-5"></i> 备注</strong>

								<p>接单小王子，欢迎来找我</p>
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>

					<!-- /.col -->
					<div class="col-md-9">
						<div class="nav-tabs-custom">
							<ul class="nav nav-tabs">
								<li class="active">
									<a href="#activity" data-toggle="tab">接单数据</a>
								</li>
								<li>
									<!--<a href="#timeline" data-toggle="tab">Timeline</a>-->
								</li>
								<li>
									<a href="#settings" data-toggle="tab">完善资料</a>
								</li>
							</ul>
							<div class="tab-content">
								<div class="active tab-pane" id="activity">
									<!-- /.row -->
									<div class="row">

										<div class="col-md-10">
											<!-- Bar chart -->
											<div class="box box-primary">
												<div class="box-header with-border">
													<i class="fa fa-bar-chart-o"></i>

													<h3 class="box-title">2022年·接单量</h3>

													<div class="box-tools pull-right">
														<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
								        </button>
														<button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
													</div>
												</div>
												<div class="box-body">
													<div id="bar-chart" style="height: 300px;"></div>
												</div>
												<!-- /.box-body-->
											</div>
											<!-- /.box -->
										</div>
										<!-- /.col -->
									</div>
									<!-- /.row -->
								</div>
								

								<div class="tab-pane" id="settings">
									<form class="form-horizontal">
										<div class="form-group">
											<label for="inputName" class="col-sm-2 control-label">姓名</label>

											<div class="col-sm-10">
												<input type="email" class="form-control" id="inputName" placeholder="Name">
											</div>
										</div>
										<div class="form-group">
											<label for="inputEmail" class="col-sm-2 control-label">学院</label>

											<div class="col-sm-10">
												<input type="email" class="form-control" id="inputEmail" placeholder="Email">
											</div>
										</div>
										<div class="form-group">
											<label for="inputName" class="col-sm-2 control-label">专业</label>

											<div class="col-sm-10">
												<input type="text" class="form-control" id="inputName" placeholder="Name">
											</div>
										</div>
										<div class="form-group">
											<label for="inputExperience" class="col-sm-2 control-label">联系方式</label>

											<div class="col-sm-10">
												<input type="text" class="form-control" id="inputName" placeholder="Name">
											</div>
										</div>
										<div class="form-group">
											<label for="inputName" class="col-sm-2 control-label">兴趣爱好</label>

											<div class="col-sm-10">
												<input type="email" class="form-control" id="inputName" placeholder="Name">
											</div>
										</div>
										<div class="form-group">
											<label for="inputName" class="col-sm-2 control-label">属地</label>

											<div class="col-sm-10">
												<input type="email" class="form-control" id="inputName" placeholder="Name">
											</div>
										</div>
										<div class="form-group">
											<label for="inputSkills" class="col-sm-2 control-label">业务技能</label>

											<div class="col-sm-10">
												<input type="text" class="form-control" id="inputSkills" placeholder="Skills">
											</div>
										</div>
										<div class="form-group">
											<label for="inputName" class="col-sm-2 control-label">备注</label>

											<div class="col-sm-10">
												<input type="email" class="form-control" id="inputName" placeholder="Name">
											</div>
										</div>
										
										
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												<button type="submit" class="btn btn-danger">提交</button>
											</div>
										</div>
									</form>
								</div>
								<!-- /.tab-pane -->
							</div>
							<!-- /.tab-content -->
						</div>
						<!-- /.nav-tabs-custom -->
					</div>
					<!-- /.col -->
				</div>
				<!-- /.row -->

			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

	</body>

</html>
<script type="text/javascript">
	$(function() {

		/*
		 * BAR CHART
		 * ---------
		 */

		var bar_data = {
			data: [
			["1月", 5],
			["2月", 7],
			["3月", 3],
			["4月", 2],
			["5月", 11],
			["6月", 21],
				["7月", 10],
				["8月", 8],
				["9月", 4],
				["10月", 13],
				["11月", 17],
				["12月", 9]
			],
			color: "#3c8dbc"
		};
		$.plot("#bar-chart", [bar_data], {
			grid: {
				borderWidth: 1,
				borderColor: "#f3f3f3",
				tickColor: "#f3f3f3"
			},
			series: {
				bars: {
					show: true,
					barWidth: 0.5,
					align: "center"
				}
			},
			xaxis: {
				mode: "categories",
				tickLength: 0
			}
		});
		/* END BAR CHART */
	})

</script>