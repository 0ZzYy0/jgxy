<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>菜单管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#treeTable").treeTable({
				expandLevel : 1,		
				column:1,
				beforeExpand : function($treeTable, id) {
		                //判断id是否已经有了孩子节点，如果有了就不再加载，这样就可以起到缓存的作
		                if ($('.' + id, $treeTable).length) { return; }
		                console.info(id)
		                $.ajax({
						    type: 'POST',
						    dataType: "html",
						    url: '${ctx}/sys/menu/getChildenList',
						    data: {"id":id} ,
						    success: function(jsonData){
			              		$treeTable.addChilds(jsonData);
						    }
						});
		        }
			});
		});
    	function updateSort() {
			loading('正在提交，请稍等...');
	    	$("#listForm").attr("action", "${ctx}/sys/menu/updateSort");
	    	$("#listForm").submit();
    	}
		function refresh(){//刷新
			
			window.location="${ctx}/sys/menu/";
		}
	</script>
</head>
<body class="gray-bg">
	<div class="wrapper-content">
	<div class="ibox">
	<div class="ibox-title">
			<h5>菜单列表 </h5>
	</div>
    <div class="ibox-content">
	<sys:message content="${message}"/>
	
		
			<!-- 工具栏 -->
	<div class="row">
	<div class="col-sm-12 m-b-sm">
		<div class="pull-left">
			<shiro:hasPermission name="sys:menu:add">
				<table:addRow url="${ctx}/sys/menu/form" title="菜单" pageModel="page"></table:addRow><!-- 增加按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:menu:edit">
			    <table:editRow url="${ctx}/sys/menu/form" id="treeTable" title="菜单" pageModel="page"></table:editRow><!-- 编辑按钮 -->
			</shiro:hasPermission> 
			<shiro:hasPermission name="sys:menu:del">
				<table:delRow url="${ctx}/sys/menu/deleteAll" id="treeTable"></table:delRow><!-- 删除按钮 -->
			</shiro:hasPermission>
			<shiro:hasPermission name="sys:menu:updateSort">
				<button id="btnSubmit" class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="updateSort()" title="保存排序"><i class="fa fa-save"></i> 保存排序</button>
			</shiro:hasPermission>
				<button class="btn btn-white btn-sm " data-toggle="tooltip" data-placement="left" onclick="refresh()" title="刷新"><i class="glyphicon glyphicon-repeat"></i> 刷新</button>
		
		</div>
	</div>
	</div>
	<form id="listForm" method="post">
	<div class="table-responsive">
		<table id="treeTable" class="table table-bordered table-striped table-hover table-condensed">
			<thead>
				<tr>
					<th><input type="checkbox" class="i-checks"></th>
					<th>名称</th>
					<th>链接</th>
					<th style="text-align:center;">排序</th>
					<th>可见</th>
					<th>权限标识</th>
					<th width="200px">操作</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${list}" var="menu">
			<c:if test="${menu.parent.id eq '1'}">
				<tr id="${menu.id}" pId="${menu.parent.id ne '1'?menu.parent.id:'0'}" haschild="true">
					<td><input type="checkbox" id="${menu.id}" class="i-checks"></td>
					<td nowrap><i class="fa ${not empty menu.icon?menu.icon:' hide'}"></i> <a href="#" onclick="openDialogView('查看菜单', '${ctx}/sys/menu/form?id=${menu.id}','800px', '500px')">${menu.name}</a></td>
					<td title="${menu.href}">${fns:abbr(menu.href,30)}</td>
					<td style="text-align:center;padding-top: 0px;padding-bottom: 0px;">
						<shiro:hasPermission name="sys:menu:updateSort">
							<input type="hidden" name="ids" value="${menu.id}"/>
							<input name="sorts" type="text" value="${menu.sort}" class="form-control" style="width:100px;text-align:center;">
						</shiro:hasPermission><shiro:lacksPermission name="sys:menu:updateSort">
							${menu.sort}
						</shiro:lacksPermission>
					</td>
					<td>${menu.isShow eq '1'?'显示':'隐藏'}</td>
					<td title="${menu.permission}">${fns:abbr(menu.permission,30)}</td>
					<td nowrap>
						<shiro:hasPermission name="sys:menu:view">
							<a href="${ctx}/sys/menu/form?id=${menu.id}" class="btn btn-info btn-xs" title="查看"><i class="fa fa-search-plus"></i></a>
						</shiro:hasPermission>
						<shiro:hasPermission name="sys:menu:edit">
	    					<a href="${ctx}/sys/menu/form?id=${menu.id}" class="btn btn-success btn-xs" title="修改"><i class="fa fa-pencil"></i></a>
	    				</shiro:hasPermission>
	    				<shiro:hasPermission name="sys:menu:del">
							<a href="${ctx}/sys/menu/delete?id=${menu.id}" onclick="return confirmx('要删除该菜单及所有子菜单项吗？', this.href)" class="btn btn-danger btn-xs" title="删除"><i class="fa fa-trash"></i></a>
						</shiro:hasPermission>
						<shiro:hasPermission name="sys:menu:add">
							<a href="${ctx}/sys/menu/form?parent.id=${menu.id}" class="btn btn-primary btn-xs" title="添加下级菜单"><i class="fa fa-plus"></i></a>
						</shiro:hasPermission>
					</td>
				</tr>
				</c:if>
			</c:forEach>
			</tbody>
		</table>
	 </div>
	 </form>
	 </div>
	</div>
	</div>
</body>
</html>