<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta charset="utf-8">
<title>黑龙江司法警官职业学院</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/jgxy/resources/images/favicon.ico">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Jquery -->
<script src="${pageContext.request.contextPath}/jgxy/resources/js/jquery-1.11.1.min.js"></script>
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/jgxy/resources/css/bootstrap.min.css" rel="stylesheet">
<!--animate-->
<link href="${pageContext.request.contextPath}/jgxy/resources/css/animate.min.css" rel="stylesheet" type="text/css" />
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/jgxy/resources/js/bootstrap.min.js"></script>

<!--swiper-->
<link href="${pageContext.request.contextPath}/jgxy/resources/css/swiper.min.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/jgxy/resources/css/certify.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/jgxy/resources/js/swiper.min.js"></script>
<!--index-->
<link href="${pageContext.request.contextPath}/jgxy/resources/css/common.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/jgxy/resources/css/index.css" rel="stylesheet" type="text/css" />
	<style>
	#certify{width: 100% !important;height: 310px;}
	#certify .swiper-slide p{display: none !important;}
	#certify .swiper-pagination{display: none !important;}
	#certify .swiper-button-prev{display: none !important;}
	#certify .swiper-button-next{display: none !important;}
	#certify .swiper-slide{height: auto;margin: 0 1%;}
	#cxtfdck{border: 1px solid #c0c0c0;margin: 0 auto;padding: 5px;background: #f0f0f0}
	.zxDiv{display: block;padding: 5px;background: -webkit-linear-gradient(right, #02B4FF , #3090FE);background: -o-linear-gradient(right, #02B4FF, #3090FE);background: -moz-linear-gradient(right, #02B4FF, #3090FE);background: linear-gradient(to right, #02B4FF , #3090FE);color: #fff;border-radius: 8px;margin: 5px 5px 5px 0;}
    
	a:link{color:white;}
	.friendship_link_wrapper{height:88%;}
	@media (min-width:768px) and (max-width:991px){
		.main_part_1_wrapepr {
			flex-wrap: wrap;
		}
		.main_part_1_wrapepr .xxgk_right_part_wrapper{
			width: 100%;
			margin-bottom: 15px;
		}
		.main_part_1_wrapepr .xxgk_right2_part_wrapper{width:100%;}
		.friendship_link_wrapper{height:auto;}
	}
	@media (max-width:767px){
		.main_part_1_wrapepr {
			flex-wrap: wrap;
		}
		.main_part_1_wrapepr .xxgk_right_part_wrapper{
			width: 100%;
			margin-bottom: 15px;
		}
		.main_part_1_wrapepr .xxgk_right2_part_wrapper{width:100%;}
		.friendship_link_wrapper{height:auto;}
	}
	</style>
</head>
<body>
	<%-- <!-- 浮动广告 div -->
<div id="floatDiv" style="z-index:999;position: absolute; left: 311; top: 815; visibility: hidden;" onmouseover="clearInterval(interval)" onmouseout="interval = setInterval('changePos()', delay)" align="middle">
    <span style="CURSOR: hand; color: red; font-weight: bold; font-size: 12px" onclick="clearInterval(interval);floatDiv.style.visibility = 'hidden'">关闭</span>
    <div id="cxtfdck">
        <a id="floatA" href="">
            <img id="floatImg" src="${pageContext.request.contextPath}/jgxy/resources/images/jingpinkecheng.jpg" style="width: 100px;" alt="" class="">
        </a>
    </div>
</div>

<!-- 自动弹出广告 div-->
<div id="modalDiv" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body text-center">
                <a id="modalA" href="">
                    <img id="modalImg" alt="" src="" style="width: 100%">
                </a>
                <br><br>
                <span id="modalSpan" style="font-size: 20px;word-warp:break-word;word-break:break-all" ></span>
            </div>
            <div class="modal-footer">
                <span id="modalSpan"></span>
            </div>
        </div>
    </div>
</div> --%>


	<!-- 校园风采展示 div-->
	<div id="schoolDiv" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog  modal-lg">
			<div class="modal-body text-center">
				<a id="schoolA" href="">
					<img id="schoolImg" src="" alt="" style="width: auto; height: auto; max-width: 100%; max-height: 100%;" />
				</a>
				<br>
				<br>
				<span id="schoolSpan" style="font-size: 20px; color: white; word-warp: break-word; word-break: break-all"></span>
			</div>
		</div>
	</div>



	<div class="index_wrapper">
		<div class="header">
			<%@ include file="headerXxgk.jsp"%>
		</div>
		
		<div class="main_part main_part_1_wrapepr fadeInUp" style="; animation-name: none;">

			<div class="col-sm-3 xxgk_right_part_wrapper">
				<div class="right_part_tittle">
					<p class="right_part_name">信息公开</p>
				</div>
				<div class="friendship_link_wrapper">
					<c:forEach items="${liftXxgkSysMenuList}" var="xxgkSysMenu" varStatus="status">
					   <a href="${ctx}/xxgk/xxgkReception/buttonList?xxgkSysMenuId=${xxgkSysMenu.id}" class="friendship_link">${xxgkSysMenu.name} </a>
					</c:forEach>
				</div>
			</div>
			
			<div class="col-sm-9 xxgk_right2_part_wrapper" style="height:100%;">
	            <div class="news_list_wrapper">
	                <c:if test="${not empty xxgkNoteList && !(xxgkNoteList eq null)}">
	                    <p class="news_list_tittle clearfix" style="text-align: center">
	                        <c:if test="${not empty xxgkSysMenuName && !(xxgkSysMenuName eq null) }">
	                            <span style="">${xxgkSysMenuName}</span>
	                        </c:if>
	                        <c:if test="${empty xxgkSysMenuName || (xxgkSysMenuName eq null) }">
	                            <span style="font-size: 22px">最新公开信息</span>
	                            <a href="${ctx}/xxgk/xxgkReception/list" class="more_info_btn pull-right">
	                                <span style="color: #2a6496">更多</span>
	                                <img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
	                            </a>
	                        </c:if>
	                    </p>
	                    <ul class="news_list">
	                        <c:forEach items="${xxgkNoteList}" var="xxgkNote" varStatus="status">
	                            <li class="single_news_wrapper">
	                                <a href="${ctx}/xxgk/xxgkReception/get?id=${xxgkNote.id}&add=1" class="single_news hover_before">
	                                    <span class="news_points"></span>
	                                    <span class="news_tittle">${xxgkNote.title}</span>
	                                    <c:if test="${status.index lt 3}">
	                                        <span class="news_state">[New]</span>
	                                    </c:if>
	                                    <span class="news_time">
	                                        <fmt:formatDate value="${xxgkNote.releaseDate}" pattern="yyyy-MM-dd" />
	                                    </span>
	                                </a>
	                            </li>
	                        </c:forEach>
	                    </ul>
	                </c:if>
	                
	                <c:if test="${not empty xxgksysMenuList && !(xxgksysMenuList eq null) }">
		                    <p class="news_list_tittle clearfix" style="text-align: center">
		                    <!-- <p class="news_list_tittle clearfix" style=""> -->
		                        <span style="font-size: 22px">${xxgkSysMenuName}</span>
		                    </p>
		                    <ul class="">
		                        <c:forEach items="${xxgksysMenuList}" var="xxgksysMenu" varStatus="status">
		                        
		                               <!-- 列表样式 -->
				                            <c:if test="${(status.index % 2) eq 0}">
				                                <div class="main_part main_part_3_wrapepr fadeInUp text-center" style="; animation-name: none;">
				                            </c:if>
				                            
				                                <div class="col-sm-6 zxDiv" style="height: 70px; text-align:center; line-height:15px;">
				                                        <a href="${ctx}/xxgk/xxgkReception/buttonList?xxgkSysMenuId=${xxgksysMenu.id}">
                                                                </br><span class="color:#F00;">${xxgksysMenu.name}</span>
				                                        </a>
				                                </div>
				        
				                            <c:if test="${(status.index % 2) eq 1}">
				                                </div>
				                            </c:if>
				                            <c:if test="${(status.index % 2) ne 1}">
				                                <c:if test="${xxgksysMenuList.size() == (status.index +1 )}">
				                                    </div>
				                                </c:if>
				                            </c:if>
                                        
                                        
                                        
                                        
                                        
                                        
		                        </c:forEach>
		                    </ul>
	                </c:if>
	             </div>
			
		                <c:forEach items="${xxgksxXxgkSysMenuList}" var="xxgkSysMenu" varStatus="status">
		
		                    <c:if test="${(status.index % 4) eq 0}">
		                        <div class="main_part main_part_3_wrapepr fadeInUp text-center" style="; animation-name: none;">
		                    </c:if>
		                    
		                        <div class="col-sm-3 zxDiv">
		                            <div class="right_part_tittle">
		                                <a href="${ctx}/xxgk/xxgkReception/buttonList?xxgkSysMenuId=${xxgkSysMenu.id}">
		                                    <span class="color:#F00">${xxgkSysMenu.name}</span>
		                                </a>
		                            </div>
		                        </div>
		
		                    <c:if test="${(status.index % 4) eq 3}">
		                        </div>
		                    </c:if>
		                    <c:if test="${(status.index % 4) ne 3}">
			                    <c:if test="${xxgksxXxgkSysMenuList.size() == (status.index +1 )}">
			                    	</div>
			                    </c:if>
		                    </c:if>
		                </c:forEach>
			</div>
		</div>
		
		</br></br>
		<div class="">
			<%@ include file="footerJgxy.jsp"%>
		</div>
	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/jgxy/resources/js/common.js"></script>
<script type="text/javascript">
    var xPos;
    var yPos;
    var step;
    var delay;
    var height;
    var Hoffset;
    var Woffset;
    var yon;
    var xon;
    var pause;
    var interval;
    $(function() {
/*      //模态广告代码↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
       $("#modalDiv").hide();
         $.ajax({
            url:"${ctx}/jgxy/jgxyReception/getModalDivJgxy",
            type:"POST",
            async:true,    //或false,是否异步
            dataType:'json',
            success:function(data){
                if(data.id != null && data.id != ""){
                    $("#modalDiv").show();
                    $('#modalDiv').modal();
                    $('#modalImg').attr('src',data.imgPath);
                    $('#modalA').attr('href',data.href);
                    $('#modalSpan').append(data.text);
                }
            },
            error:function(){
                //alert("出错");
            }
        });
        //模态广告代码↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
        
        
        //悬浮广告代码↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
        $("#floatDiv").hide();
        $.ajax({
            url:"${ctx}/jgxy/jgxyReception/getFloatDivJgxy",
            type:"POST",
            async:true,    //或false,是否异步
            dataType:'json',
            success:function(data){
                if(data.id != null && data.id != ""){
                    $("#floatDiv").show();
                    xPos = 20;
                    yPos = document.body.clientHeight;
                    step = 1;
                    delay = 30;
                    height = 0;
                    Hoffset = 0;
                    Woffset = 0;
                    yon = 0;
                    xon = 0;
                    pause = true;
                    interval;
                    floatDiv.style.top = yPos;
                    $("#floatA").attr('href',data.href);
                    $("#floatImg").attr('src',data.imgPath);
                    start();
                }else{
                    
                }
            },
            error:function(){
                //alert("出错");
            }
        });
        //悬浮广告代码↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑ */


        // banner
        $('#myCarousel').carousel({
            interval : 5000,
        });

        $('#jnsc').bind('keyup', function(event) {
            　　if (event.keyCode == "13") {
            　　　　//回车执行查询
            　　　　//$('#search_button').click();
                toList();
            　　}
            });
        //控制标题的字数显示
        $('.news_tittle').addClass('test');
        $('.test').removeClass('news_tittle');

    });

    window.onload = function() {

        // 滚动动画
       //window_scroll();

        // 搜索事件
        $('.search_btn').on('click', function() {
            var search_val = $('.search_input').val();
        });
        

        $('.test').addClass('news_tittle');
    }

    
    function changePos() {
        width = document.body.clientWidth;
        height = document.body.clientHeight;
        Hoffset = floatDiv.offsetHeight;
        Woffset = floatDiv.offsetWidth;
        floatDiv.style.left = xPos + document.body.scrollLeft;
        floatDiv.style.top = yPos + document.body.scrollTop;
        if (yon) {
            yPos = yPos + step;
        } else {
            yPos = yPos - step;
        }
        if (yPos < 0) {
            yon = 1;
            yPos = 0;
        }
        if (yPos >= (height - Hoffset)) {
            yon = 0;
            yPos = (height - Hoffset);
        }
        if (xon) {
            xPos = xPos + step;
        } else {
            xPos = xPos - step;
        }
        if (xPos < 0) {
            xon = 1;
            xPos = 0;
        }
        if (xPos >= (width - Woffset)) {
            xon = 0;
            xPos = (width - Woffset);
        }
    }
    function start() {
        floatDiv.style.visibility = "visible";
        interval = setInterval('changePos()', delay);
    }
    
    //校园风采  点击变大
    function showImg(imgTitle,imgPath){
        $("#schoolSpan").append(imgTitle);
        $("#schoolImg").attr('src',imgPath);
        $('#schoolDiv').modal();
    }
    
    
    
    
</script>
</html>