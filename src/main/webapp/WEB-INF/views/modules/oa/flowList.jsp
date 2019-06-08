<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>流程列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		
		function toApply(type, title, id){
			
			//自定义流程
			if(type == "0"){
				parent.location.href = '${ctx}/oa/oaCommonAudit/form?oaCommonFlowId='+id;
				//openDialog('新建'+title, '${ctx}/oa/oaCommonAudit/form?oaCommonFlowId='+id,'800px', '500px')
			}
			
			//请假流程
			if(type == "1"){
				parent.location.href = '${ctx}/oa/oaCommonLeave/form?oaCommonAudit.oaCommonFlowId='+id;
				//openDialog('新建'+title, '${ctx}/oa/oaCommonLeave/form?oaCommonAudit.oaCommonFlowId='+id,'800px', '500px')
			}

			//报销单流程
			if(type == "2"){
				parent.location.href = '${ctx}/oa/oaCommonExpense/form?oaCommonAudit.oaCommonFlowId='+id;
				//openDialog('新建'+title, '${ctx}/oa/oaCommonExpense/form?oaCommonAudit.oaCommonFlowId='+id,'800px', '500px')
			}

			//差旅单流程
			if(type == "3"){
				parent.location.href = '${ctx}/oa/oaCommonTravel/form?oaCommonAudit.oaCommonFlowId='+id;
				//openDialog('新建'+title, '${ctx}/oa/oaCommonTravel/form?oaCommonAudit.oaCommonFlowId='+id,'800px', '500px')
			}

			//借款单流程
			if(type == "4"){
				parent.location.href = '${ctx}/oa/oaCommonBorrow/form?oaCommonAudit.oaCommonFlowId='+id;
				//openDialog('新建'+title, '${ctx}/oa/oaCommonBorrow/form?oaCommonAudit.oaCommonFlowId='+id,'800px', '500px')
			}

			//加班单流程
			if(type == "5"){
				parent.location.href = '${ctx}/oa/oaCommonExtra/form?oaCommonAudit.oaCommonFlowId='+id;
				//openDialog('新建'+title, '${ctx}/oa/oaCommonExtra/form?oaCommonAudit.oaCommonFlowId='+id,'800px', '500px')
			}
			
		}
	</script>
								
</head>
<body class="gray-bg">
    <div class="wrapper-content">
    	<div class="ibox">
			<div class="ibox-title">
				<h5>审批列表 </h5>
				<div class="ibox-tools">
                    <a href="${ctx}/oa/oaCommonFlow/">
                        <i class="fa fa-cog"></i> 流程设置
                    </a>
                </div>
			</div>
			<div class="ibox-content">
			
	    	    <c:if test="${page.list == null || fn:length(page.list) == 0}">
					<div class="alert alert-danger">
	                     	您还未进行审批流程配置，请前往 <a class="alert-link" href="${ctx}/oa/oaCommonFlow">流程配置</a>.
	            	</div>
	            </c:if>   
         
		        <div class="row">
		        	<div class="col-sm-4">
		                <div class="ibox">
		                    <div class="ibox-title">
		                        <span class="label label-primary pull-right">普通流程</span>
		                        <h5>自定义流程</h5>
		                    </div>
		                    <div class="ibox-content">
		                        <div class="team-members">
		                        </div>
		                        <p>
		                        	
		                        </p>
		                        <div class="row">
		                        	<div class="pull-right">
		                            	<a class="btn btn-white btn-sm" href="${ctx}/oa/oaCommonAudit/form" target="_parent"><i class="fa fa-plus"></i> 立即申请</a>
		                            </div>
		                        </div>
		                    </div>
		                </div>
					</div>
		        	<c:forEach items="${page.list}" var="oaCommonFlow">
		            <div class="col-sm-4">
		                <div class="ibox">
		                    <div class="ibox-title">
		                        <span class="label label-primary pull-right">${fns:getDictLabel(oaCommonFlow.type, 'common_audit_type', '')}</span>
		                        <h5>${oaCommonFlow.title}</h5>
		                    </div>
		                    <div class="ibox-content">
		                        <div class="team-members">
		                        </div>
		                        <p>
		                        	${oaCommonFlow.remarks}
		                        </p>
		                        <div class="row">
		                        	<div class="pull-right">
		                            	<button class="btn btn-white btn-sm" type="button" onclick="toApply('${oaCommonFlow.type}','${oaCommonFlow.title}','${oaCommonFlow.id}')"><i class="fa fa-plus"></i> 立即申请</button>
		                            	<button class="btn btn-white btn-sm" type="button" onclick="openDialog('查看流程', '${ctx}/oa/oaCommonFlow/view?id=${oaCommonFlow.id}','800px', '500px')"><i class="fa fa-search"></i> 查看流程</button>
		                            </div>
		                        </div>
		                    </div>
		                </div>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</body>
</html>