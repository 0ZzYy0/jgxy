<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>校园风采查看</title>
	<meta name="decorator" content="default"/>
</head>
<body class="gray-bg">
<div class="wrapper-content">
<div class="ibox">
	<div class="ibox-title">
		<h5>校园风采查看</h5>
	</div>
	<div class="ibox-content">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="jgxyImgSchool" action="${ctx}/jgxy/jgxyImgSchool/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">是否发布：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${fns:getDictLabel(jgxyImgSchool.isRelease, 'is_release', '')}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">图片：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							<input type="hidden" id="imgPath" value="${jgxyImgSchool.}"/>
							<sys:ckfinder id="imgPath" type="images" uploadPath="/jgxy" readonly="true"/>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">图片标题：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyImgSchool.imgTitle}
							</p>
						</div>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">排序：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyImgSchool.sort}
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-6">
					<div class="view-group">
						<label class="col-sm-4 control-label">备注：</label>
						<div class="col-sm-8">
							<p class="form-control-static">
							${jgxyImgSchool.remark}
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
							<shiro:hasPermission name="jgxy:jgxyImgSchool:edit">
						    	<a href="${ctx}/jgxy/jgxyImgSchool/form?id=${jgxyImgSchool.id}" class="btn btn-success" title="修改">修改</a>
							</shiro:hasPermission>
							<shiro:hasPermission name="jgxy:jgxyImgSchool:del">
								<a href="${ctx}/jgxy/jgxyImgSchool/delete?id=${jgxyImgSchool.id}" onclick="return confirmx('确认要删除该校园风采吗？', this.href)" class="btn btn-danger" title="删除">删除</a> 
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