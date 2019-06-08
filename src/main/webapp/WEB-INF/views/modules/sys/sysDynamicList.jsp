<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>动态管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
		//0:隐藏tip, 1隐藏box,不设置显示全部
		top.$.jBox.closeTip();
	</script>
</head>
<body class="gray-bg">
<div class="wrapper-content">
		<div class="ibox">
			<div class="ibox-title">
				<h5>动态列表 </h5>
			</div>
			<div class="ibox-content">
			<sys:message content="${message}"/>
				
				<!-- 查询条件 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" modelAttribute="sysDynamic" action="${ctx}/sys/sysDynamic/" method="post" class="form-inline">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
								<%-- 
								<div class="form-group"><span>对象类型：</span>
									<form:select path="objectType" class="form-control input-medium">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('object_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
								<div class="form-group"><span>动作类型：</span>
									<form:select path="actionType" class="form-control input-medium">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('action_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
								--%>
								<%--<div class="form-group"><span>对象ID：</span>
									<form:input path="targetId" htmlEscape="false" maxlength="30" class="form-control input-medium"/>
								</div>
								<div class="form-group"><span>对象名称：</span>
									<form:input path="targetName" htmlEscape="false" maxlength="50" class="form-control input-medium"/>
								</div>
								--%>
								<div class="form-group"><span>操作人：</span>
									<sys:treeselect id="createBy" name="createBy.id" value="${sysDynamic.createBy.id}" labelName="createBy.name" labelValue="${sysDynamic.createBy.name}"
										title="用户" url="/sys/office/treeData?type=3" cssClass="form-control input-medium" allowClear="true" notAllowSelectParent="true"/>
								</div>
								<div class="form-group"><span>操作时间：</span>
									<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="laydate-icon form-control input-medium"
										value="<fmt:formatDate value="${sysDynamic.beginCreateDate}" pattern="yyyy-MM-dd"/>"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/> - 
									<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="laydate-icon form-control input-medium"
										value="<fmt:formatDate value="${sysDynamic.endCreateDate}" pattern="yyyy-MM-dd"/>"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
								</div>
								<%-- 
								<div class="form-group"><span>关联客户：</span>
									<form:input path="customerId" htmlEscape="false" maxlength="30" class="form-control input-medium"/>
								</div>
								--%>
						</form:form>
					</div>
				</div>
				<!-- 工具栏 -->
				<div class="row">
					<div class="col-sm-12 m-b-sm">
						<div class="pull-left">
							<%-- 
							<shiro:hasPermission name="sys:sysDynamic:add">
								<table:addRow url="${ctx}/sys/sysDynamic/form" title="动态"></table:addRow><!-- 增加按钮 -->
							</shiro:hasPermission>
							<shiro:hasPermission name="sys:sysDynamic:edit">
							    <table:editRow url="${ctx}/sys/sysDynamic/form" title="动态" id="contentTable"></table:editRow><!-- 编辑按钮 -->
							</shiro:hasPermission>
							<shiro:hasPermission name="sys:sysDynamic:del">
								<table:delRow url="${ctx}/sys/sysDynamic/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
							</shiro:hasPermission>
							<shiro:hasPermission name="sys:sysDynamic:import">
								<table:importExcel url="${ctx}/sys/sysDynamic/import"></table:importExcel><!-- 导入按钮 -->
							</shiro:hasPermission>
							
							<shiro:hasPermission name="sys:sysDynamic:export">
					       		<table:exportExcel url="${ctx}/sys/sysDynamic/export"></table:exportExcel><!-- 导出按钮 -->
					       	</shiro:hasPermission>
					       	--%>
					       <button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="sortOrRefresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
						
						</div>
						<div class="pull-right">
							<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="search()" ><i class="fa fa-search"></i> 查询</button>
							<button  class="btn btn-primary btn-rounded btn-outline btn-sm " onclick="resetSearch()" ><i class="fa fa-refresh"></i> 重置</button>
						</div>
					</div>
				</div>
				<br>
				<div class="ibox-content">
				<div class="chat-activity-list">
					<c:forEach items="${page.list }" var="sysDynamic"> 
					<div class="chat-element">
	                                <a href="#" onclick="openDialogView('查看用户信息', '${ctx}/sys/user/view?id=${sysDynamic.createBy.id}','800px', '500px')" class="pull-left">
	                                    <img alt="${sysDynamic.createBy.name}" class="img-circle" src="${sysDynamic.createBy.photo}" onerror="this.src='http://www.yee800.com/user.png'">
	                                </a>
	                                <div class="media-body ">
	                                    <small class="pull-right hide"><fmt:formatDate value="${sysDynamic.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></small>
	                                    <strong>${sysDynamic.createBy.name}</strong>&nbsp;&nbsp;<i>${fns:getDictLabel(sysDynamic.actionType, 'action_type', '')}了</i>&nbsp;&nbsp;${fns:getDictLabel(sysDynamic.objectType, 'object_type', '')}
	                                    <p class="m-b-xs well">
	                                        
								<a href="#" onclick="toView('${sysDynamic.objectType}','${sysDynamic.targetId}');">${sysDynamic.targetName}</a>
	                                    </p>
	                                    <small class="text-muted">${fns:getTimeDiffer(sysDynamic.createDate)}</small>
	                                </div>
	                            </div>                     	
	               </c:forEach>
                </div>
                <table:page page="${page}"></table:page>
                </div>           	
				<br>
			</div>
		</div>
	</div>
</body>
</html>