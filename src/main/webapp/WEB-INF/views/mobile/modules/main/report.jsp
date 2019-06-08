<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
  <head>
      <title>报表</title>
      <%@ include file="/WEB-INF/views/include/weuihead.jsp"%>
      <style type="text/css">
      	.weui-grid_label{
      		text-align: center;
      		color: #23b7e5;
      	}
      	.weui-cell__bd{
      		font-size: 13px;
      	}
      </style>
  </head>
  <body ontouchstart>
	<div class="page-content">
    <div class="weui-cells__title">数据总览（当月）</div>
    <div class="weui-grids">
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.ownNum }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">负责客户数</span>
        </p>
      </div>
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.createChangeNum }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">创建机会数</span>
        </p>
      </div>
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.ownChangeNum }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">负责机会数</span>
        </p>
      </div>
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.createOrderNum }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">签单数</span>
        </p>
      </div>
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.createOrderAmt }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">签单总额</span>
        </p>
      </div>
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.recOrderAmt }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">回款总额</span>
        </p>
      </div>
    </div>
    
	<div class="weui-cells__title">个人提醒（当天）</div>
	<div class="weui-grids">
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.dayUnContactCustomerNum }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">今日需联系</span>
        </p>
      </div>
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.dayContactCustomerNum }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">今日已联系</span>
        </p>
      </div>
      <div class="weui-grid js_grid">
        <div class="weui-grid_label">
          ${myCrmReport.dayCreateCustomerNum }
        </div>
        <p class="weui-grid__label">
          	<span class="weui-media-box__desc">今日创建</span>
        </p>
      </div>
    </div>
	
	<div class="weui-cells__title">阶段分析（当月）</div>
	<div class="weui-cells">
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>初步恰接</p>
            </div>
            <div class="weui-cell__ft">${myCrmReport.purposeCustomerNum }</div>
          </div>
    
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>需求确定</p>
            </div>
            <div class="weui-cell__ft">${myCrmReport.demandCustomerNum }</div>
          </div>
    
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>方案报价</p>
            </div>
            <div class="weui-cell__ft">${myCrmReport.quoteCustomerNum }</div>
          </div>
   
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>签订合同</p>
            </div>
            <div class="weui-cell__ft">${myCrmReport.dealOrderNum }</div>
          </div>
    
          <div class="weui-cell">
            <div class="weui-cell__bd">
              <p>销售回款</p>
            </div>
            <div class="weui-cell__ft">${myCrmReport.completeOrderNum }</div>
          </div>
          
    </div>
    <div class="weui-cells__title"></div>
    
	</div>
    <c:set value="2" var="nav"></c:set>
 	<%@ include file="foot.jsp"%>

  </body>
</html>
