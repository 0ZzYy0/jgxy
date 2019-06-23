<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>模态窗口管理列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body class="">
	<div class="">
		<div class="">
			<div class="ibox-header">
				<h5>模态窗口管理列表 </h5>
				<div class="pull-right">
					<button id="searchBtn" class="btn btn-default btn-sm" title="搜索"><i class="fa fa-search"></i> 搜索</button><!-- 搜索按钮 -->
					<shiro:hasPermission name="jgxy:jgxyModalDiv:add">
						<table:addRow url="${ctx}/jgxy/jgxyModalDiv/form" title="模态窗口管理" pageModel="page"></table:addRow><!-- 增加按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyModalDiv:edit">
					    <table:editRow url="${ctx}/jgxy/jgxyModalDiv/form" title="模态窗口管理" id="contentTable" pageModel="page"></table:editRow><!-- 编辑按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyModalDiv:del">
						<table:delRow url="${ctx}/jgxy/jgxyModalDiv/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyModalDiv:import">
						<table:importExcel url="${ctx}/jgxy/jgxyModalDiv/import"></table:importExcel><!-- 导入按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyModalDiv:export">
			       		<table:exportExcel url="${ctx}/jgxy/jgxyModalDiv/export"></table:exportExcel><!-- 导出按钮 -->
			       	</shiro:hasPermission>
				</div>
			</div>
			<div class="ibox-content">
			<sys:message content="${message}"/>				
				<!-- 查询栏 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" modelAttribute="jgxyModalDiv" action="${ctx}/jgxy/jgxyModalDiv/" method="post" class="form-inline">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
							<table:searchRow></table:searchRow>
								<div class="form-group"><span>配置名称：</span>
									<form:input path="name" htmlEscape="false" maxlength="255" class="form-control input-medium"/>
								</div>
								<div class="form-group">
									<button class="btn btn-white btn-sm " onclick="search()"><i class="fa fa-search"></i> 查询</button>
									<button class="btn btn-white btn-sm " onclick="resetSearch()"><i class="fa fa-refresh"></i> 重置</button>
								</div>
						</form:form>
					</div>
				</div>
							
				<!-- 数据表格 -->
				<div class="table-responsive">
				<table id="contentTable" class="table table-bordered table-striped table-hover">
					<thead>
						<tr>
							<th width="30px"><input type="checkbox" class="i-checks"></th>
							<th class="sort-column a.name">配置名称</th>
							<th class="sort-column a.state">状态</th>
							<th class="sort-column a.href">超链接</th>
							<th width="200px">操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="jgxyModalDiv">
						<tr>
							<td><input type="checkbox" id="${jgxyModalDiv.id}" class="i-checks"></td>
							<td>
								<a href="${ctx}/jgxy/jgxyModalDiv/view?id=${jgxyModalDiv.id}" title="查看">
								${jgxyModalDiv.name}
							</a></td>
							<td>
								${fns:getDictLabel(jgxyModalDiv.state, 'jgxyState', '')}
							</td>
							<td>
								${jgxyModalDiv.href}
							</td>
							<td>
								<shiro:hasPermission name="jgxy:jgxyModalDiv:view">
									<a href="${ctx}/jgxy/jgxyModalDiv/view?id=${jgxyModalDiv.id}" class="btn btn-info btn-xs" title="查看"><i class="fa fa-search-plus"></i> 查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="jgxy:jgxyModalDiv:edit">
			    					<a href="${ctx}/jgxy/jgxyModalDiv/form?id=${jgxyModalDiv.id}" class="btn btn-success btn-xs" title="修改"><i class="fa fa-pencil"></i> 修改</a>
								</shiro:hasPermission>
								
								<shiro:hasPermission name="jgxy:jgxyModalDiv:del">
									<a href="${ctx}/jgxy/jgxyModalDiv/delete?id=${jgxyModalDiv.id}" onclick="return confirmx('确认要删除该模态窗口管理吗？', this.href)" class="btn btn-danger btn-xs" title="删除"><i class="fa fa-trash"></i> 删除</a> 
								</shiro:hasPermission>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
				<table:page page="${page}"></table:page>
				</div>
			</div>
		</div>
	</div>
</body>
</html>