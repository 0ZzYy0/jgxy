<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
    <script src="${pageContext.request.contextPath}/jgxy/ueditor/ueditor.config.js"></script>
    <script src="${pageContext.request.contextPath}/jgxy/ueditor/ueditor.all.min.js"> </script>
    <!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
    <!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
    <script src="${pageContext.request.contextPath}/jgxy/ueditor/lang/zh-cn/zh-cn.js"></script>
    
	<title>文章编辑</title>
	<meta name="decorator" content="default"/>
<script type="text/javascript">
    var ue = UE.getEditor('contents');
	var validateForm;
	function doSubmit(){//回调函数，在编辑和保存动作时，供openDialog调用提交表单。
	  if(validateForm.form()){
		  $("#inputForm").submit();
		  return true;
	  }

	  return false;
	}
	$(document).ready(function() {
		//$("#name").focus();
		validateForm=$("#inputForm").validate({
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
<div class="wrapper-content">
<div class="ibox">
	<div class="ibox-title">
		<h5>文章${not empty jgxyNote.id?'修改':'添加'}</h5>
	</div>
	<div class="ibox-content">
		<sys:message content="${message}"/>
		<form:form id="inputForm" modelAttribute="jgxyNote" action="${ctx}/jgxy/jgxyNote/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
			<h4 class="page-header">基本信息</h4>
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group">
						<label class="col-sm-4 control-label"><font color="red">*</font> 文章分类：</label>
						<div class="col-sm-8">
							<sys:treeselect id="jgxySysMenu" name="jgxySysMenu.id" value="${jgxyNote.jgxySysMenu.id}" labelName="jgxySysMenu.name" labelValue="${jgxyNote.jgxySysMenu.name}"
								title="文章分类" url="/jgxy/jgxySysMenu/treeData" cssClass="form-control required" allowClear="true" notAllowSelectParent="true"/>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"> 文章标题：</label>
                        <div class="col-sm-8">
                            <form:input path="title" htmlEscape="false" maxlength="50" class="form-control"/>
                        </div>
                    </div>
                </div>
			</div>
			<div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"><font color="red">*</font> 发布日期：</label>
                        <div class="col-sm-8">
                            <div class="input-group date datepicker">
                                <input name="releaseDate" path="releaseDate" type="text" readonly="readonly" class="form-control" 
                                    value="<fmt:formatDate value="${jgxyNote.releaseDate}" pattern="yyyy-MM-dd"/>" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});" >
                                <span class="input-group-addon">
                                    <span class="fa fa-calendar"></span>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label"> 点击量：</label>
                        <div class="col-sm-8">
                            <form:input path="clickThroughput" htmlEscape="false" maxlength="50" class="form-control"/>
                        </div>
                    </div>
                </div>
            </div>
			<div class="row">
				<div class="col-sm-12">
					<div class="form-group">
						<label class="col-sm-2 control-label"> 内容：</label>
						<div class="col-sm-8">
							<form:textarea id="contents" path="contents" htmlEscape="false" rows="4" maxlength="10000"/>
							<!-- <textarea id="contents"  name="contents" rows="" cols=""></textarea> -->
							<%-- <sys:umeditor replace="contents" uploadPath="/jgxy" maxlength="10000"/> --%>
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