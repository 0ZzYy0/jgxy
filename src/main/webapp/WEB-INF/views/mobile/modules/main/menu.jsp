<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
  <head>
      <title>${fns:getSysAccount().systemName}</title>
      <%@ include file="/WEB-INF/views/include/weuihead.jsp"%>
  </head>
  <body>
	<div class="page-content">
	
	<%--
    <header class='demos-header'>
      <h2 class="demos-title">${fns:getSysAccount().systemName}</h2>
      <p class='demos-sub-title'>集成企业微信，更高效智能</p>
    </header>
	 --%>
    
    <div class="weui-cells__title">销售管理</div>
    <div class="weui-grids">
      <a href="${ctx}/mobile/crm/crmCustomer" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_button.png" alt="">
        </div>
        <p class="weui-grid__label">
          	客户
        </p>
      </a>
      <a href="${ctx}/mobile/crm/crmContacter" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_panel.png" alt="">
        </div>
        <p class="weui-grid__label">
          	联系人
        </p>
      </a>
      <a href="${ctx}/mobile/crm/crmCustomerPool/" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_search_bar.png" alt="">
        </div>
        <p class="weui-grid__label">
         	 公海
        </p>
      </a>
    </div>
    <div class="weui-cells__title">机会开发</div>
    <div class="weui-grids">
      <a href="${ctx}/mobile/crm/crmChance" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_cell.png" alt="">
        </div>
        <p class="weui-grid__label">
          	机会
        </p>
      </a>
      <a href="${ctx}/mobile/crm/crmQuote" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_msg.png" alt="">
        </div>
        <p class="weui-grid__label">
          	报价
        </p>
      </a>
      <a href="${ctx}/mobile/crm/crmContract" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_toast.png" alt="">
        </div>
        <p class="weui-grid__label">
         	 合同
        </p>
      </a>
    </div>
     
    <div class="weui-cells__title">工作审批</div>
    <div class="weui-grids">
      <a href="${ctx}/mobile/oa/oaCommonAudit/list" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_dialog.png" alt="">
        </div>
        <p class="weui-grid__label">
          	审批
        </p>
      </a>
      
      <a href="${ctx}/mobile/oa/oaNotify/list" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_notify.png" alt="">
        </div>
        <p class="weui-grid__label">
          	公告
        </p>
      </a>
      
      <a href="${ctx}/mobile/oa/oaWorkLog/self" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_icons.png" alt="">
        </div>
        <p class="weui-grid__label">
          	汇报
        </p>
      </a>
      <%-- 
      <a href="" class="weui-grid js_grid">
        <div class="weui-grid__icon">
          <img src="${ctxStatic}/weui/demos/images/icon_nav_city.png" alt="">
        </div>
        <p class="weui-grid__label">
         	 写说说
        </p>
      </a>
      --%>
    </div>
	<div class="weui-cells__title"></div>
    </div>
    
 	<c:set value="0" var="nav"></c:set>
 	<%@ include file="foot.jsp"%>
  </body>
</html>