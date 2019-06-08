<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE html>
<html>
  <head>
      <title>${fns:getSysAccount().systemName}</title>
      <%@ include file="/WEB-INF/views/include/weuihead.jsp"%>
  </head>
  <body>
	
	
    <div class="weui-tabbar">
        <a href="${ctx}/mobile/report" class="weui-tabbar__item <c:if test='${nav == 2}'>weui-bar__item--on</c:if>">
          <div class="weui-tabbar__icon">
            <img src="${ctxStatic}/weui/demos/images/icon_nav_button.png" alt="">
          </div>
          <p class="weui-tabbar__label">报表</p>
        </a>
        <a href="${ctx}/mobile/menu" class="weui-tabbar__item <c:if test='${nav == 0}'>weui-bar__item--on</c:if>">
          <div class="weui-tabbar__icon">
            <img src="${ctxStatic}/weui/demos/images/icon_nav_msg.png" alt="">
          </div>
          <p class="weui-tabbar__label">功能</p>
        </a>
        <a href="${ctx}/mobile/news" class="weui-tabbar__item <c:if test='${nav == 3}'>weui-bar__item--on</c:if>">
          <div class="weui-tabbar__icon">
            <img src="${ctxStatic}/weui/demos/images/icon_nav_article.png" alt="">
          </div>
          <p class="weui-tabbar__label">提醒</p>
        </a>
        <a href="${ctx}/mobile/more" class="weui-tabbar__item <c:if test='${nav == 4}'>weui-bar__item--on</c:if>">
          <div class="weui-tabbar__icon">
            <img src="${ctxStatic}/weui/demos/images/icon_nav_cell.png" alt="">
          </div>
          <p class="weui-tabbar__label">关于</p>
        </a>
      </div>
 
  </body>
</html>
