<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>前台页脚查看</title>
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
<div class="wrapper-content">
<div class="ibox">
	<div class="ibox-title">
		<h5>前台页脚查看</h5>
	</div>
	<div class="ibox-content">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="jgxyFooter" action="${ctx}/jgxy/jgxyFooter/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">配置名称：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyFooter.name}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">状态：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${fns:getDictLabel(jgxyFooter.state, 'jgxyState', '')}
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div class="view-group">
						<label class="col-sm-4 control-label">文本内容：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyFooter.contents}
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
							<shiro:hasPermission name="jgxy:jgxyFooter:edit">
						    	<a href="${ctx}/jgxy/jgxyFooter/form?id=${jgxyFooter.id}" class="btn btn-success" title="修改">修改</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="jgxy:jgxyFooter:del">
								<a href="${ctx}/jgxy/jgxyFooter/delete?id=${jgxyFooter.id}" onclick="return confirmx('确认要删除该前台页脚吗？', this.href)" class="btn btn-danger" title="删除">删除</a> 
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