<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单(树结构)查看</title>
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
<div class="wrapper-content">
<div class="ibox">
	<div class="ibox-title">
		<h5>菜单(树结构)查看</h5>
	</div>
	<div class="ibox-content">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="jgxySysMenu" action="${ctx}/jgxy/jgxySysMenu/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">上级分类：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxySysMenu.parent.id}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">所有父级编号：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxySysMenu.parentIds}
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">菜单名称：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxySysMenu.name}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">排序：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxySysMenu.sort}
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">更新者：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxySysMenu.updateBy.id}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">更新时间：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							<fmt:formatDate value="${jgxySysMenu.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">备注信息：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxySysMenu.remarks}
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
							<shiro:hasPermission name="jgxy:jgxySysMenu:edit">
						    	<a href="${ctx}/jgxy/jgxySysMenu/form?id=${jgxySysMenu.id}" class="btn btn-success" title="修改">修改</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="jgxy:jgxySysMenu:del">
								<a href="${ctx}/jgxy/jgxySysMenu/delete?id=${jgxySysMenu.id}" onclick="return confirmx('确认要删除该菜单(树结构)吗？', this.href)" class="btn btn-danger" title="删除">删除</a> 
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