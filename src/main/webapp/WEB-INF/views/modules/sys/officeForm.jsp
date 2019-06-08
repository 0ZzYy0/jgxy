<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		var validateForm;
		function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
		  if(validateForm.form()){
			  $("#inputForm").submit();
			  return true;
		  }
	
		  return false;
		}
		$(document).ready(function() {
			$("#name").focus();
			validateForm = $("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body class="gray-bg">
<div class="">
	<div class="ibox">
		<div class="ibox-title">
			<h5>机构${not empty office.id?'修改':'添加'}</h5>
		</div>
		<div class="ibox-content">
			<sys:message content="${message}"/>
			<form:form id="inputForm" modelAttribute="office" action="${ctx}/sys/office/save" method="post" class="form-horizontal">
				<form:hidden path="id"/>
				<h4 class="page-header">基本信息</h4>
				<div class="row">
					<div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">上级机构</label>
			            	 <div class="col-sm-8">
			                 	<sys:treeselect id="office" name="parent.id" value="${office.parent.id}" labelName="parent.name" labelValue="${office.parent.name}"
									title="机构" url="/sys/office/treeData" extId="${office.id}"  cssClass="form-control" allowClear="${office.currentUser.admin}"/>
			                 </div>
			            </div>
		            </div>
		            <div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">是否可用</label>
			            	 <div class="col-sm-8">
			                      <form:select path="useable" cssClass="form-control">
									<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
			                 </div>
			            </div>
		            </div>
		            <%-- 
		            <div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">归属区域</label>
			            	 <div class="col-sm-8">
			                      <sys:treeselect id="area" name="area.id" value="${office.area.id}" labelName="area.name" labelValue="${office.area.name}"
									title="区域" url="/sys/area/treeData" cssClass="form-control"/>
			                 </div>
			            </div>
		            </div>
		            --%>
		        </div>
		        <div class="row">
					<div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label"><font color="red">*</font>机构名称</label>
			            	 <div class="col-sm-8">
			                 	<form:input path="name" htmlEscape="false" maxlength="50" class="form-control required"/>
			                 </div>
			            </div>
		            </div>
		            <div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">机构编码</label>
			            	 <div class="col-sm-8">
			                      <form:input path="code" htmlEscape="false" maxlength="50" class="form-control"/>
			                 </div>
			            </div>
		            </div>
		        </div>
		        <div class="row">
					<div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label"><font color="red">*</font>机构类型</label>
			            	 <div class="col-sm-8">
			                 	<form:select path="type" class="form-control">
									<form:options items="${fns:getDictList('sys_office_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
			                 </div>
			            </div>
		            </div>
		            <div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">机构级别</label>
			            	 <div class="col-sm-8">
			                      <form:select path="grade" class="form-control">
									<form:options items="${fns:getDictList('sys_office_grade')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
								</form:select>
			                 </div>
			            </div>
		            </div>
		        </div>
		        <h4 class="page-header">负责人信息</h4>
		        <div class="row">
					<div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">负责人</label>
			            	 <div class="col-sm-8">
			                 	<form:input path="master" htmlEscape="false" maxlength="50" cssClass="form-control" />
			                 </div>
			            </div>
		            </div>
		            <div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">电话</label>
			            	 <div class="col-sm-8">
			                      <form:input path="phone" htmlEscape="false" maxlength="50" cssClass="form-control" />
			                 </div>
			            </div>
		            </div>
		        </div>
		        <div class="row">
					<div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">地址</label>
			            	 <div class="col-sm-8">
			                 	<form:input path="address" htmlEscape="false" maxlength="50" cssClass="form-control" />
			                 </div>
			            </div>
		            </div>
		            <div class="col-sm-6">
						<div class="form-group">
			            	<label class="col-sm-4 control-label">邮编</label>
			            	 <div class="col-sm-8">
			                      <form:input path="zipCode" htmlEscape="false" maxlength="50" cssClass="form-control" />
			                 </div>
			            </div>
		            </div>
		        </div>
		        <h4 class="page-header">其他信息</h4>
		        <div class="row">
					<div class="col-sm-12">
						<div class="form-group">
			            	<label class="col-sm-2 control-label">备注</label>
			            	 <div class="col-sm-10">
			                 	<form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="50" class="form-control"/>
			                 </div>
			            </div>
		            </div>
		        </div>
		        <div class="hr-line-dashed"></div>
				<div class="row">
					<div class="col-sm-12">
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button id="btnSubmit" class="btn btn-primary" type="submit">保存</button>&nbsp;
								<button id="btnCancel" class="btn btn-white" type="button" onclick="history.go(-1)">返回</button>
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