<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文章查看</title>
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
<div class="wrapper-content">
<div class="ibox">
	<div class="ibox-title">
		<h5>文章查看</h5>
	</div>
	<div class="ibox-content">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="xxgkNote" action="${ctx}/xxgk/xxgkNote/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
                <div class="col-sm-6">
                    <div class="view-group">
                        <label class="col-sm-4 control-label">标题：</label>
                        <div class="col-sm-8">
                            <p class="form-control-static">
                            ${xxgkNote.title}
                            </p>
                        </div>
                    </div>
                </div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">文章分类：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${xxgkNote.xxgkSysMenu.name}
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
							${xxgkNote.updateBy.id}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">发布时间：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							<fmt:formatDate value="${xxgkNote.releaseDate}" pattern="yyyy-MM-dd"/>
							<%-- <fmt:formatDate value="${xxgkNote.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
                    <div class="view-group">
                        <label class="col-sm-4 control-label">点击量：</label>
                        <div class="col-sm-8">
                            <p class="form-control-static">
                            ${xxgkNote.clickThroughput}
                            </p>
                        </div>
                    </div>
                </div>
			</div>
			<div class="row">
				<div class="col-sm-12">
					<div class="view-group">
						<label class="col-sm-2 control-label">内容：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${xxgkNote.contents}
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
							<shiro:hasPermission name="xxgk:xxgkNote:edit">
						    	<a href="${ctx}/xxgk/xxgkNote/form?id=${xxgkNote.id}" class="btn btn-success" title="修改">修改</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="xxgk:xxgkNote:del">
								<a href="${ctx}/xxgk/xxgkNote/delete?id=${xxgkNote.id}" onclick="return confirmx('确认删除吗？', this.href)" class="btn btn-danger" title="删除">删除</a> 
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