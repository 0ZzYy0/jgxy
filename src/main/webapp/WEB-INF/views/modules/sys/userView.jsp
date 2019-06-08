<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>个人资料</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		//0:隐藏tip, 1隐藏box,不设置显示全部
		top.$.jBox.closeTip();
	</script>
</head>
<body class="">
				<sys:message content="${message}"/>
				<div class="col-sm-12">
					<div class="">
						<div class="ibox-content">
							<div class="row">
								<div class="col-sm-2" style="margin-bottom: 10px;">
									<img alt="image" class="img-responsive" src="${user.photo }" />
								</div>
								<div class="col-sm-8">
									<div class="table-responsive">
										<table class="table table-bordered">
											<tbody>
												<tr>
													<td width="200px"><strong>姓名</strong></td>
													<td>${user.name}</td>
												</tr>
												<tr>
													<td><strong>邮箱</strong></td>
													<td>${user.email}</td>
												</tr>
												<tr>
													<td><strong>手机</strong></td>
													<td>${user.mobile}</td>
												</tr>
												<tr>
													<td><strong>电话</strong></td>
													<td>${user.phone}</td>
												</tr>
												<tr>
													<td><strong>公司</strong></td>
													<td>${user.company.name}</td>
												</tr>
												<tr>
													<td><strong>部门</strong></td>
													<td>${user.office.name}</td>
												</tr>
												<tr>
													<td><strong>备注</strong></td>
													<td>${user.remarks}</td>
												</tr>
											</tbody>
										</table>
										
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

</body>
</html>