<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
  <head>
      <title>关于</title>
      <%@ include file="/WEB-INF/views/include/weuihead.jsp"%>
  </head>
  <body ontouchstart>
  	
  	<div class="weui-cells margin-top0">
            <div class="weui-cell">
                <div class="weui-cell__hd" style="position: relative;margin-right: 10px;">
                    <img src="${fns:getUser().photo}" style="width: 50px;display: block;">
                    <%-- 
                    <span class="weui-badge" style="position: absolute;top: -.4em;right: -.4em;">V</span>
                    --%>
                </div>
                <div class="weui-cell__bd">
                    <p>${fns:getUser().name}</p>
                    <p style="font-size: 13px;color: #888888;">
                    	${fns:getSysAccount().name }                    
                    </p>
                </div>
            </div>
        </div>
        
	
    <div class="bd">
      <div class="page__bd">
      	<%--
      	<div class="weui-cells__title">内部消息</div>
        <div class="weui-cells">

          <a class="weui-cell weui-cell_access" href="${ctx }/oa/oaNotify/self">
            <div class="weui-cell__bd">
              <p>通知公告</p>
            </div>
            <div class="weui-cell__ft">
            	<c:if test="${notifyCount >0}">
            	<span class="weui-badge" style="margin-left: 5px;margin-right: 5px;">${notifyCount}</span>
            	</c:if>
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="${ctx}/iim/mailBox/list?orderBy=sendtime desc">
            <div class="weui-cell__bd">
              <p>内部消息</p>
            </div>
            <div class="weui-cell__ft">
            	<c:if test="${notifyCount >0}">
            	<span class="weui-badge" style="margin-left: 5px;margin-right: 5px;">${noReadCount}</span>
            	</c:if>
            </div>
          </a>
        </div>
      	 --%>
      	
      	
        <div class="weui-cells">
        	<%-- 
          <a class="weui-cell weui-cell_access" href="javascript:;">
            <div class="weui-cell__bd">
              <p>我的账号</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          --%>
          
          <a class="weui-cell weui-cell_access" href="#">
            <div class="weui-cell__bd">
              <p>当前版本：企业版</p>              
            </div>
            <div class="weui-cell__ft">
            	<p class="weui-media-box__desc"><i class="weui-icon-success-no-circle"></i>已授权</p>
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="mqqwpa://im/chat?chat_type=wpa&uin=3237155221&version=1&src_type=web&web_src=oicqzone.com">
            <div class="weui-cell__bd">
              <p>在线客服</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
          <a class="weui-cell weui-cell_access" href="${ctx}/mobile/about">
            <div class="weui-cell__bd">
              <p>关于我们</p>
            </div>
            <div class="weui-cell__ft">
            </div>
          </a>
        </div>
        
        
      </div>
    </div>
    <c:set value="4" var="nav"></c:set>
 	<%@ include file="foot.jsp"%>
 
  </body>
</html>
