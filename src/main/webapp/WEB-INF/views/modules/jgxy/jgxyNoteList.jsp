<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>文章列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body class="">
	<div class="">
		<div class="">
			<div class="ibox-header">
				<h5>文章列表 </h5>
				<div class="pull-right">
					<button id="searchBtn" class="btn btn-default btn-sm" title="搜索"><i class="fa fa-search"></i> 搜索</button><!-- 搜索按钮 -->
					<shiro:hasPermission name="jgxy:jgxyNote:add">
						<table:addRow url="${ctx}/jgxy/jgxyNote/form" title="文章" pageModel="page"></table:addRow><!-- 增加按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyNote:edit">
					    <table:editRow url="${ctx}/jgxy/jgxyNote/form" title="文章" id="contentTable" pageModel="page"></table:editRow><!-- 编辑按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyNote:del">
						<table:delRow url="${ctx}/jgxy/jgxyNote/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyNote:import">
						<table:importExcel url="${ctx}/jgxy/jgxyNote/import"></table:importExcel><!-- 导入按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyNote:export">
			       		<table:exportExcel url="${ctx}/jgxy/jgxyNote/export"></table:exportExcel><!-- 导出按钮 -->
			       	</shiro:hasPermission>
				</div>
			</div>
			<div class="ibox-content">
			<sys:message content="${message}"/>				
				<!-- 查询栏 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" modelAttribute="jgxyNote" action="${ctx}/jgxy/jgxyNote/" method="post" class="form-inline">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							
							<input id="jgxySysMenuId" name="jgxySysMenuId" type="hidden" value="${jgxySysMenuId}"/>
							
							
							<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
							<table:searchRow></table:searchRow>
								<div class="form-group"><span>文章分类：</span>
								</div>
								<div class="form-group"><span>标题：</span>
									<form:input path="title" htmlEscape="false" maxlength="50" class="form-control input-medium"/>
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
							<th><input type="checkbox" class="i-checks"></th>
							<th class="sort-column a.remarks">文章分类</th>
							<th class="sort-column a.title">标题</th>
							<th class="sort-column a.click_throughput">点击量</th>
							<th class="sort-column a.release_Date">发布时间</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="jgxyNote">
						<tr>
							<td><input type="checkbox" id="${jgxyNote.id}" class="i-checks"></td>
							<td>
								${jgxyNote.jgxySysMenu.name}
							</td>
							<td>
								${jgxyNote.title}
							</td>
							<td>
                                ${jgxyNote.clickThroughput}
                            </td>
                            <td>
                                <fmt:formatDate value="${jgxyNote.releaseDate}" pattern="yyyy-MM-dd"/>
                            </td>
							<td>
								<shiro:hasPermission name="jgxy:jgxyNote:view">
									<a href="${ctx}/jgxy/jgxyNote/view?id=${jgxyNote.id}" class="btn btn-info btn-xs" title="查看"><i class="fa fa-search-plus"></i> 查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="jgxy:jgxyNote:edit">
			    					<a href="${ctx}/jgxy/jgxyNote/form?id=${jgxyNote.id}" class="btn btn-success btn-xs" title="修改"><i class="fa fa-pencil"></i> 修改</a>
								</shiro:hasPermission>
								
								<shiro:hasPermission name="jgxy:jgxyNote:del">
									<a href="${ctx}/jgxy/jgxyNote/delete?id=${jgxyNote.id}" onclick="return confirmx('确认删除吗？', this.href)" class="btn  btn-danger btn-xs" title="删除"><i class="fa fa-trash"></i> 删除</a> 
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