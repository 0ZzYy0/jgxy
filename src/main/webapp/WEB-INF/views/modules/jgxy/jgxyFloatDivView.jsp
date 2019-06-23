<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>悬浮窗口查看</title>
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
<div class="wrapper-content">
<div class="ibox">
	<div class="ibox-title">
		<h5>悬浮窗口查看</h5>
	</div>
	<div class="ibox-content">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="jgxyFloatDiv" action="${ctx}/jgxy/jgxyFloatDiv/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">配置名称：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyFloatDiv.name}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">状态：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${fns:getDictLabel(jgxyFloatDiv.state, 'jgxyState', '')}
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">图片：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							<input type="hidden" id="imgPath" value="${jgxyFloatDiv.}"/>
							<sys:ckfinder id="imgPath" type="images" uploadPath="/jgxy" readonly="true"/>
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">超链接：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyFloatDiv.href}
							</p>
						</div>
					</div>
				</div>
			</div>
			
			<div class="hr-line-dashed"></div>
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group">
						<div class="col-sm-offset-2 col-sm-10">
							<shiro:hasPermission name="jgxy:jgxyFloatDiv:edit">
						    	<a href="${ctx}/jgxy/jgxyFloatDiv/form?id=${jgxyFloatDiv.id}" class="btn btn-success" title="修改">修改</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="jgxy:jgxyFloatDiv:del">
								<a href="${ctx}/jgxy/jgxyFloatDiv/delete?id=${jgxyFloatDiv.id}" onclick="return confirmx('确认要删除该悬浮窗口吗？', this.href)" class="btn btn-danger" title="删除">删除</a> 
							</shiro:hasPermission>
							<a id="btnCancel" class="btn btn-white" onclick="history.go(-1)">返回</a>
						</div>
					</div>
				</div>
			</div>
		</form:form>
	</div>
</div>
</div>
</body>
</html>