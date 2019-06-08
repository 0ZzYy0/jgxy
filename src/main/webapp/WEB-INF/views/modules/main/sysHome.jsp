<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>主页</title>
	<meta name="decorator" content="default"/>    
	<link href="${ctxStatic}/hplus/css/calendar.css" rel="stylesheet">	
    <script type="text/javascript">
	    $(document).ready(function() {
	    	 setInterval(function(){$("#currentTime").html(current)},1000);
	    	getNotepaper();
	    });
	    
	    function current(){
		    var d=new Date(),str='';
		    $("#currentDate").html(d.getFullYear()+"/"+d.getMonth()+1+"/"+d.getDate());		    
		    str +=d.getHours()+':';
		    str +=d.getMinutes()+':';
		    str +=d.getSeconds()+'';
		    return str; 
	    }
	   
	    function getNotepaper(){	    	
		    $.ajax({
	    		url:"${ctx}/oa/oaNote/getNote",
	    		type:"POST",
	    		async:true,    //或false,是否异步
	    		dataType:'json',
	    		success:function(data){	    			
	    			if(data != null && data != "false" && data.notes != null){	    				
	    				$("#notepaper").val(data.notes);
	    			}
	    		},
	    		error:function(){
	    			//alert("出错");
	    		}
	    	});
	    }
	    function saveNotepaper(){
	    	var notepaper = $("#notepaper").val();
	    	$.ajax({
	    		url:"${ctx}/oa/oaNote/saveNote",
	    		type:"POST",
	    		async:true,    //或false,是否异步
	    		data:{notes:notepaper},
	    		dataType:'json',
	    		success:function(data){
	    			//alert(data);
	    		},
	    		error:function(){
	    			//alert("出错");
	    		}
	    	});
	    }
	    function toView(objectType, targetId){
	    	//object_type对象类型    10：项目，11：任务，12:日报，13：通知，14：审批，20：客户，21：联系人，22：机会，23：报价，24：合同订单，25:沟通, 26:订单，27：退货单，30：产品：31：采购，32：入库，33：出库，34：移库，39：供应商，36：盘点，37:调拨，   50：应收款，51：应付款， 52：收款单，53：付款单
	    	if(objectType == "11"){//任务
	    		window.location.href = "${ctx}/oa/oaTask/view?id="+targetId;
	    	}
	    	if(objectType == "20"){//客户
	    		window.location.href = "${ctx}/crm/crmCustomer/crmIndex?id="+targetId;
	    	}
	    	if(objectType == "21"){
	    		openDialogView("联系人", "${ctx}/crm/crmContacter/view?id="+targetId, '800px', '500px');
	    	}
	    	if(objectType == "22"){//机会
	    		window.location.href = "${ctx}/crm/crmChance/view?id="+targetId;
	    	}
	    	if(objectType == "23"){//报价
	    		window.location.href = "${ctx}/crm/crmQuote/view?id="+targetId;
	    	}
	    	if(objectType == "24"){//合同订单
	    		window.location.href = "${ctx}/om/omContract/view?id="+targetId;
	    	}
	    	if(objectType == "25"){
	    		openDialogView("跟进记录", "${ctx}/crm/crmContactRecord/view?id="+targetId, '800px', '500px');
	    	}
	    	if(objectType == "26"){//订单
	    		window.location.href = "${ctx}/om/omOrder/view?id="+targetId;
	    	}
	    	if(objectType == "27"){//退货单
	    		window.location.href = "${ctx}/om/omReturnorder/view?id="+targetId;
	    	}
	    	if(objectType == "39"){
	    		openDialogView("供应商", "${ctx}/wms/wmsSupplier/view?id="+targetId, '800px', '500px');
	    	}
	    	if(objectType == "31"){//采购单
	    		window.location.href = "${ctx}/wms/wmsPurchase/view?id="+targetId;
	    	}
	    	if(objectType == "32"){//入库单
	    		window.location.href = "${ctx}/wms/wmsInstock/view?id="+targetId;
	    	}
	    	if(objectType == "33"){//出库单
	    		window.location.href = "${ctx}/wms/wmsOutstock/view?id="+targetId;
	    	}
	    	if(objectType == "50"){//应收款
	    		window.location.href = "${ctx}/fi/fiReceiveAble/view?id="+targetId;
	    	}
	    	if(objectType == "51"){//应付款
	    		window.location.href = "${ctx}/fi/fiPaymentAble/view?id="+targetId;
	    	}
	    	if(objectType == "52"){
	    		openDialogView("收款单", "${ctx}/fi/fiReceiveBill/view?id="+targetId, '800px', '500px');
	    	}
	    	if(objectType == "53"){
	    		openDialogView("付款单", "${ctx}/fi/fiPaymentBill/view?id="+targetId, '800px', '500px');
	    	}
	    }
    </script>
</head>

<body class="gray-bg">
	
    <div class="wrapper-content">
		<sys:message content="${message}"/>
        <div class="row">
        	<div class="col-sm-2">
                
                
               <div class="ibox float-e-margins hide">
                   <div class="ibox-title">                        
	                        <h5>签到</h5>
	               </div>
                   <div class="ibox-content">
                   		<div class="well">
                            <h3 id="currentTime">
                            </h3>
                            <span id="currentDate"></span>
                        </div>
                        <button id="checkBtn" class="btn btn-info btn-block m-t checkBtn hide" onclick="javascript:check(1);">
                        	<span><i class="fa fa-edit"></i>签到</span>
                        </button>
                    </div>
                </div>      
            	<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>我的便笺</h5>
                    </div>
                    <div class="ibox-content">
                    	<textarea id="notepaper" name="notepaper" rows="" cols="" class="form-control" style="height: 100px;width: 100%" onblur="saveNotepaper()"></textarea>
                    </div>
                </div>
                
            	<div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>我的足迹</h5>
                        <div class="ibox-tools">
                            <a href="${ctx}/sys/sysBrowseLog/" target="mainFrame">
                                <i class="fa fa-chevron-right"></i>
                            </a>
                    	</div>
                    </div>                    
                   <div class="ibox-content no-padding">
                   		<ul class="list-group">
                    	    <c:forEach items="${browseLogPage.list }" var="browseLog">   
                    		<li class="list-group-item" >                                	
                                <div class="agile-detail">
                                	<a href="${ctx}/crm/crmCustomer/crmIndex?id=${browseLog.targetId}" class="block-link">${browseLog.targetName }</a>                                  	
                                </div>
                            </li>
                            </c:forEach>                 	
                        </ul>
                    </div>
                </div>

            </div>
            <div class="col-sm-7">
	        	<div class="ibox float-e-margins">
	            	<div class="ibox-title">                        
	                	<h5>团队动态</h5>
	                	<div class="ibox-tools">
                            <a href="${ctx}/sys/sysDynamic" target="mainFrame">
                                <i class="fa fa-chevron-right"></i>
                            </a>
                    	</div>
	           		</div>
	            	<div class="ibox-content">
						<form:form id="searchForm" modelAttribute="sysDynamic" action="${ctx}/home" method="post" class="form-inline">
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
						</form:form>	
                        <div>
                            <div class="chat-activity-list">

								<c:forEach items="${sysDynamicPage.list }" var="sysDynamic"> 
								<div class="chat-element">
                                    <a href="#" onclick="openDialogView('查看用户信息', '${ctx}/sys/user/view?id=${sysDynamic.createBy.id}','800px', '500px')" class="pull-left">
                                        <img alt="${sysDynamic.createBy.name}" class="img-circle" src="${sysDynamic.createBy.photo}">
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
                            <a href="${ctx}/sys/sysDynamic" class="btn btn-white btn-block m"><i class="fa fa-arrow-down"></i> 查看更多</a>
                        </div>
                    </div>
	       		</div>

            </div>
            <div class="col-sm-3">
                
                
                <div class="ibox float-e-margins">
                    <div class="ibox-title">                        
                        <h5>通知公告</h5>
                        <div class="ibox-tools">
                            <a href="${ctx}/oa/oaNotify/self" target="mainFrame"><i class="fa fa-chevron-right"></i></a>
                    	</div>
                    </div>
                    <div class="ibox-content">
                    	<c:forEach items="${newNotifyList }" var="newNotify" begin="0" end="0">
                    		${newNotify.content }
                    	</c:forEach>                    	
                    </div>
                </div>
                <div class="ibox float-e-margins hide">
                    <div class="ibox-title">                        
                        <h5>总览</h5>
                    </div>
                    <div class="ibox-content">
                    	
                    	<div>		                    
		                      <table class="table">
		                        <tbody>
		                            <tr>
		                                <td style="border-color: #fff;">
		                                    <button type="button" class="btn btn-danger btn-circle m-r-sm" onclick="javascript:window.location.href='${ctx }/oa/oaNotify/self'"><i class="fa fa-bell-o"></i></button>
		                                   	<br>消息
		                                </td>
		                                <td style="border-color: #fff;">
		                                    <button type="button" class="btn btn-primary btn-circle m-r-sm" onclick="javascript:window.location.href='${ctx }/oa/oaTask/self'"><i class="fa fa-tag"></i></button>
		                                 	 <br>任务
		                                </td style="border-color: #fff;">
		                                <td style="border-color: #fff;">
		                                    <button type="button" class="btn btn-info btn-circle m-r-sm" onclick="javascript:window.location.href='${ctx }/iim/myCalendar'"><i class="fa fa-calendar-check-o"></i></button>
		                                  	<br>日程
		                                </td>
		                            </tr>
		                            <tr>
		                                <td>
		                                    <button type="button" class="btn btn-info btn-circle m-r-sm" onclick="javascript:window.location.href='${ctx }/crm/crmCustomer/'"><i class="fa fa-user"></i></button>
		                                   	 <br>客户
		                                </td>
		                                <td>
		                                    <button type="button" class="btn btn-success btn-circle m-r-sm" onclick="javascript:window.location.href='${ctx }/crm/crmChance'"><i class="fa fa-send-o"></i></button>
		                                   	 <br>机会
		                                </td>
		                                <td>
		                                    <button type="button" class="btn btn-danger btn-circle m-r-sm" onclick="javascript:window.location.href='${ctx }/om/omOrder'"><i class="fa fa-file-o"></i></button>
		                                	<br>订单
		                                </td>
		                            </tr>
		                            
		                            <%-- 
		                            <tr>
		                                <td>
		                                    <button type="button" class="btn btn-warning btn-circle m-r-sm">5</button>
		                                    	采购
		                                </td>
		                                <td>
		                                    <button type="button" class="btn btn-default btn-circle m-r-sm">3</button>
		                                    	入库
		                                </td>
		                                <td>
		                                    <button type="button" class="btn btn-warning btn-circle m-r-sm">60</button>
		                                    	出库
		                                </td>
		                            </tr>
		                             <tr>
		                             	<td>
		                                    <button type="button" class="btn btn-info btn-circle m-r-sm">2</button>
		                                    	账户
		                                </td>
		                                <td>
		                                    <button type="button" class="btn btn-danger btn-circle m-r-sm">6</button>
		                                    	应收
		                                </td>
		                                <td>
		                                    <button type="button" class="btn btn-info btn-circle m-r-sm">1</button>
		                                    	应付
		                                </td>		                                
		                            </tr>
		                            --%>
		                        </tbody>
		                    </table>
                		</div>
                    	
                    </div>
                </div>
                
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>我的日程</h5>
                        <div class="ibox-tools">
                            <a href="${ctx}/iim/myCalendar" target="mainFrame"><i class="fa fa-chevron-right"></i></a>
                    	</div>
                    </div>                    
                    <div class="ibox-content no-padding" style="height: 350px;">
                    	<iframe class="J_iframe" name="iframe2" id="iframe2" width="100%" height="100%" src="${ctx}/iim/myCalendar/myCalendarView" frameborder="0" data-id="${ctx}/home" seamless></iframe>
                    </div>
                </div>
                
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>流程审批</h5>
                        <div class="ibox-tools">
                            <a href="${ctx}/oa/oaCommonAudit" target="mainFrame">
                                <i class="fa fa-chevron-right"></i>
                            </a>
                    	</div>
                    </div>                    
                   <div class="ibox-content no-padding">
                   		<ul class="list-group">
                    	<c:forEach items="${oaCommonAuditPage.list}" var="oaCommonAudit">                   	
							<li class="list-group-item">
								 <div class="agile-detail">
                                	<a href="${ctx}/oa/oaCommonAudit/view?id=${oaCommonAudit.id}" class="block-link">${oaCommonAudit.title}</a>
                                	<c:if test="${fns:getUser().id == oaCommonAudit.currentBy.id && oaCommonAudit.status == 1}">                               	
                                		<a href="#" onclick="openDialogView('查看流程审批', '${ctx}/oa/oaCommonAudit/view?id=${oaCommonAudit.id}','1000px', '80%')" class="pull-right btn btn-xs btn-success">待我审批</a>  
                                	</c:if>
                                </div>
							</li>	
                        </c:forEach>
                        </ul>
                    </div>
                </div>
                
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>我的任务</h5>
                        <div class="ibox-tools">
                            <a href="${ctx}/oaHome" target="mainFrame">
                                <i class="fa fa-chevron-right"></i>
                            </a>
                    	</div>
                    </div>                    
                   <div class="ibox-content no-padding">
                   		<ul class="list-group">
                    	<c:forEach items="${taskPage.list }" var="oaTask">                   	
							<li class="list-group-item">
								 <div class="agile-detail">
                                	<a href="${ctx}/oa/oaTask/view?id=${oaTask.id}" class="block-link">${oaTask.name}</a>                                	
                                	 <a href="#" onclick="openDialogView('查看任务', '${ctx}/oa/oaTask/view?id=${oaTask.id}','1000px', '80%')" class="pull-right btn btn-xs btn-white"> ${oaTask.schedule}%</a>  
                                </div>
							</li>	
                        </c:forEach>
                        </ul>
                    </div>
                </div>
                
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>待联系客户</h5>
                        <div class="ibox-tools">
                            <a href="${ctx}/crmHome" target="mainFrame">
                                <i class="fa fa-chevron-right"></i>
                            </a>
                    	</div>
                    </div>                    
                   <div class="ibox-content no-padding">
                   		<ul class="list-group">
                    	 <c:forEach items="${contactCustomerPage.list }" var="crmCustomer">                  	
							<li class="list-group-item">
								 <div class="agile-detail">
                                	<a href="${ctx}/crm/crmCustomer/crmIndex?id=${crmCustomer.id}" class="block-link">${crmCustomer.name}</a>                                	
                                	 <a href="${ctx}/crm/crmCustomer/crmIndex?id=${crmCustomer.id}" class="pull-right btn btn-xs btn-white"><fmt:formatDate value="${crmCustomer.nextcontactDate}" pattern="MM-dd"/></a>  
                                </div>
							</li>	
                        </c:forEach>
                        </ul>
                    </div>
               </div>
                
                
               
            </div>
            
        </div>
    </div>
   
   
</body>
</html>