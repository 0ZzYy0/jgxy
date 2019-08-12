<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单(树结构)列表</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
			var data = ${fns:toJson(list)}, ids = [], rootIds = [];
			for (var i=0; i<data.length; i++){
				ids.push(data[i].id);
			}
			ids = ',' + ids.join(',') + ',';
			for (var i=0; i<data.length; i++){
				if (ids.indexOf(','+data[i].parentId+',') == -1){
					if ((','+rootIds.join(',')+',').indexOf(','+data[i].parentId+',') == -1){
						rootIds.push(data[i].parentId);
					}
				}
			}
			for (var i=0; i<rootIds.length; i++){
				addRow("#treeTableList", tpl, data, rootIds[i], true);
			}
			$("#treeTable").treeTable({expandLevel : 5});
		});
		function addRow(list, tpl, data, pid, root){
			for (var i=0; i<data.length; i++){
				var row = data[i];
				if ((${fns:jsGetVal('row.parentId')}) == pid){
					$(list).append(Mustache.render(tpl, {
						dict: {
						blank123:0}, pid: (root?0:pid), row: row
					}));
					addRow(list, tpl, data, row.id);
				}
			}
		}
		function refresh(){//刷新
			
			window.location="${ctx}/xxgk/xxgkSysMenu/";
		}
	</script>
</head>
<body class="">
	<div class="">
	<div class="">
	<div class="ibox-header">
		<h5>菜单(树结构)列表 </h5>
		<div class="pull-right">
				<button id="searchBtn" class="btn btn-default btn-sm" title="搜索"><i class="fa fa-search"></i> 搜索</button><!-- 搜索按钮 -->
				<shiro:hasPermission name="xxgk:xxgkSysMenu:add">
					<table:addRow url="${ctx}/xxgk/xxgkSysMenu/form" title="菜单(树结构)" pageModel="page"></table:addRow><!-- 增加按钮 -->
				</shiro:hasPermission>
		</div>
	</div>
    
    <div class="ibox-content">
	<sys:message content="${message}"/>

	<!--查询条件-->
	<div class="row">
	<div class="col-sm-12">
		<form:form id="searchForm" modelAttribute="xxgkSysMenu" action="${ctx}/xxgk/xxgkSysMenu/" method="post" class="form-inline">
			<table:searchRow></table:searchRow>
				<div class="form-group">
				<span>菜单名称：</span>
					<form:input path="name" htmlEscape="false" maxlength="50" class="form-control input-medium"/>
				</div>
				<div class="form-group">
					<button class="btn btn-white btn-sm " onclick="search()"><i class="fa fa-search"></i> 查询</button>
					<button class="btn btn-white btn-sm " onclick="resetSearch()"><i class="fa fa-refresh"></i> 重置</button>
				</div>
		</form:form>
	</div>
	</div>
	
	<div class="table-responsive">
	<table id="treeTable" class="table table-bordered table-striped table-hover">
		<thead>
			<tr>
				<th>菜单名称</th>
				<th>排序</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="treeTableList"></tbody>
	</table>
	</div>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}">
			<td>
				<a href="${ctx}/xxgk/xxgkSysMenu/form?id={{row.id}}" title="查看">
				{{row.name}}
			</a></td>
			<td>
				{{row.sort}}
			</td>
			<td>
			<shiro:hasPermission name="xxgk:xxgkSysMenu:edit">
   				<a href="${ctx}/xxgk/xxgkSysMenu/form?id={{row.id}}" class="btn btn-success btn-xs" title="修改">修改</a>
   			</shiro:hasPermission>   			
   			<shiro:hasPermission name="xxgk:xxgkSysMenu:add">
				<a href="${ctx}/xxgk/xxgkSysMenu/form?parent.id={{row.id}}" class="btn btn-primary btn-xs" title="添加下级菜单(树结构)">添加下级菜单(树结构)</a>
			</shiro:hasPermission>
			<shiro:hasPermission name="xxgk:xxgkSysMenu:del">
				<a href="${ctx}/xxgk/xxgkSysMenu/delete?id={{row.id}}" onclick="return confirmx('确认要删除该菜单(树结构)及所有子菜单(树结构)吗？', this.href)" class="btn btn-danger btn-xs" title="删除">删除</a>
			</shiro:hasPermission>
			</td>
		</tr>
	</script>
</body>
</html>