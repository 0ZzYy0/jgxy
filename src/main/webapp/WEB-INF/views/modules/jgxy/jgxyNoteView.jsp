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
		<form:form id="inputForm" modelAttribute="jgxyNote" action="${ctx}/jgxy/jgxyNote/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
                <div class="col-sm-6">
                    <div class="view-group">
                        <label class="col-sm-4 control-label">标题：</label>
                        <div class="col-sm-8">
                            <p class="form-control-static">
                            ${jgxyNote.title}
                            </p>
                        </div>
                    </div>
                </div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">文章分类：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyNote.jgxySysMenu.name}
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
							${jgxyNote.updateBy.id}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">更新时间：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							<fmt:formatDate value="${jgxyNote.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">内容：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyNote.contents}
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
							<shiro:hasPermission name="jgxy:jgxyNote:edit">
						    	<a href="${ctx}/jgxy/jgxyNote/form?id=${jgxyNote.id}" class="btn btn-success" title="修改">修改</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="jgxy:jgxyNote:del">
								<a href="${ctx}/jgxy/jgxyNote/delete?id=${jgxyNote.id}" onclick="return confirmx('确认删除吗？', this.href)" class="btn btn-danger" title="删除">删除</a> 
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