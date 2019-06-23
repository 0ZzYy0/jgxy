<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>模态窗口管理查看</title>
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
<div class="wrapper-content">
<div class="ibox">
	<div class="ibox-title">
		<h5>模态窗口管理查看</h5>
	</div>
	<div class="ibox-content">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="jgxyModalDiv" action="${ctx}/jgxy/jgxyModalDiv/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">配置名称：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyModalDiv.name}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">状态：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${fns:getDictLabel(jgxyModalDiv.state, 'jgxyState', '')}
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">文字：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyModalDiv.text}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">图片：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							<input type="hidden" id="imgPath" value="${jgxyModalDiv.}"/>
							<sys:ckfinder id="imgPath" type="images" uploadPath="/jgxy" readonly="true"/>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">超链接：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyModalDiv.href}
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
							<shiro:hasPermission name="jgxy:jgxyModalDiv:edit">
						    	<a href="${ctx}/jgxy/jgxyModalDiv/form?id=${jgxyModalDiv.id}" class="btn btn-success" title="修改">修改</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="jgxy:jgxyModalDiv:del">
								<a href="${ctx}/jgxy/jgxyModalDiv/delete?id=${jgxyModalDiv.id}" onclick="return confirmx('确认要删除该模态窗口管理吗？', this.href)" class="btn btn-danger" title="删除">删除</a> 
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