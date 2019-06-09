<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>校园风采列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	</script>
</head>
<body class="">
	<div class="">
		<div class="">
			<div class="ibox-header">
				<h5>校园风采列表 </h5>
				<div class="pull-right">
					<button id="searchBtn" class="btn btn-default btn-sm" title="搜索"><i class="fa fa-search"></i> 搜索</button><!-- 搜索按钮 -->
					<shiro:hasPermission name="jgxy:jgxyImgSchool:add">
						<table:addRow url="${ctx}/jgxy/jgxyImgSchool/form" title="校园风采" pageModel="page"></table:addRow><!-- 增加按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyImgSchool:edit">
					    <table:editRow url="${ctx}/jgxy/jgxyImgSchool/form" title="校园风采" id="contentTable" pageModel="page"></table:editRow><!-- 编辑按钮 -->
					</shiro:hasPermission>
					<shiro:hasPermission name="jgxy:jgxyImgSchool:del">
						<table:delRow url="${ctx}/jgxy/jgxyImgSchool/deleteAll" id="contentTable"></table:delRow><!-- 删除按钮 -->
					</shiro:hasPermission>
				</div>
			</div>
			<div class="ibox-content">
			<sys:message content="${message}"/>				
				<!-- 查询栏 -->
				<div class="row">
					<div class="col-sm-12">
						<form:form id="searchForm" modelAttribute="jgxyImgSchool" action="${ctx}/jgxy/jgxyImgSchool/" method="post" class="form-inline">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
							<table:sortColumn id="orderBy" name="orderBy" value="${page.orderBy}" callback="sortOrRefresh();"/><!-- 支持排序 -->
							<table:searchRow></table:searchRow>
								<div class="form-group"><span>是否发布：</span>
									<form:select path="isRelease" class="form-control input-medium">
										<form:option value="" label=""/>
										<form:options items="${fns:getDictList('is_release')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
									</form:select>
								</div>
								<div class="form-group"><span>图片标题：</span>
									<form:input path="imgTitle" htmlEscape="false" maxlength="500" class="form-control input-medium"/>
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
							<th class="sort-column a.is_release">是否发布</th>
							<th class="sort-column a.img_title">图片标题</th>
							<th class="sort-column a.sort">排序</th>
							<th class="sort-column a.remark">备注</th>
							<th width="200px">操作</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${page.list}" var="jgxyImgSchool">
						<tr>
							<td><input type="checkbox" id="${jgxyImgSchool.id}" class="i-checks"></td>
							<td>
								${fns:getDictLabel(jgxyImgSchool.isRelease, 'is_release', '')}
							</td>
							<td>
								${jgxyImgSchool.imgTitle}
							</td>
							<td>
								${jgxyImgSchool.sort}
							</td>
							<td>
								${jgxyImgSchool.remark}
							</td>
							<td>
								<shiro:hasPermission name="jgxy:jgxyImgSchool:view">
									<a href="${ctx}/jgxy/jgxyImgSchool/view?id=${jgxyImgSchool.id}" class="btn btn-info btn-xs" title="查看"><i class="fa fa-search-plus"></i> 查看</a>
								</shiro:hasPermission>
								<shiro:hasPermission name="jgxy:jgxyImgSchool:edit">
			    					<a href="${ctx}/jgxy/jgxyImgSchool/form?id=${jgxyImgSchool.id}" class="btn btn-success btn-xs" title="修改"><i class="fa fa-pencil"></i> 修改</a>
								</shiro:hasPermission>
								
								<shiro:hasPermission name="jgxy:jgxyImgSchool:del">
									<a href="${ctx}/jgxy/jgxyImgSchool/delete?id=${jgxyImgSchool.id}" onclick="return confirmx('确认要删除该校园风采吗？', this.href)" class="btn btn-danger btn-xs" title="删除"><i class="fa fa-trash"></i> 删除</a> 
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