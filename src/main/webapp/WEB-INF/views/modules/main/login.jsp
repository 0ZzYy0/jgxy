<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="decorator" content="default"/>
	<title>警官学院新闻发布平台登录</title>
  	<meta name="description" content="警官学院新闻发布平台">
  	<meta name="keywords" content="警官学院新闻发布平台">
  	<style type="text/css">
  		input,button{
  			height: 34px !important;
  		}
  	</style>
  	<script type="text/javascript">
	  	if (window.top !== window.self) {
			window.top.location = window.location;
		}
	  	$(document).ready(function() {
			$("#loginForm").validate({
				rules: {
					validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
				},
				messages: {
					username: {required: "请填写用户名."},password: {required: "请填写密码."},
					validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
				},
				errorLabelContainer: "#messageBox",
				errorPlacement: function(error, element) {
					error.appendTo($("#loginError").parent());
				} 
			});
		});
		// 如果在框架或在对话框中，则弹出提示并跳转到首页
		if(self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0){
			alert('未登录或登录超时。请重新登录，谢谢！');
			top.location = "${ctx}";
		}
  	</script>
</head>
<body class="signin">
	 
    <div class="signinpanel">
    	<div class="login-logo">
		     警官学院新闻发布平台 
		</div>
		<sys:message content="${message}"/>	
        <div class="row">
            <div class="col-sm-12">
                <form id="loginForm" class="form-signin" action="${ctx}/login" method="post">
                   
                    <p class="login-box-msg">请输入您的账号密码进行登录</p>
                    <div class="form-group">
                    	<input type="text" id="username" name="username" class="form-control uname required" placeholder="账号" />
                    </div>
                    <div class="form-group">
                    	<input type="password" id="password" name="password" class="form-control pword m-b required" placeholder="密码" />
                    </div>
                    <c:if test="${isValidateCodeLogin}">
                    	<div class="form-group">
                    		验证码：<sys:validateCode name="validateCode"/>
                    	</div>
                    </c:if>
                    <div class="form-group">
                    	<input type="checkbox" id="rememberMe" name="rememberMe" checked="checked" class="i-checks"> 下次自动登录 
                    </div>
                    <div class="form-group">
                   		<button type="submit" class="btn btn-success btn-block">登录</button>
                    </div>
                    <div class="form-group">

                    </div>
                    
                </form>
            </div>
        </div>
        
        <div class="signup-footer">
        
            <div class="">
                &copy; copyright 2019 警官学院新闻发布平台 
            </div>
            <br>
             <p class="login-box-msg">快速演示账号/密码：admin/admin</p>
        </div>
    </div>

    
    

</body>
</html>