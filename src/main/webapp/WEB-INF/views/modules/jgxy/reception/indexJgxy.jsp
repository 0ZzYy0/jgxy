<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8">
<title>黑龙江司法警官职业学院</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/jgxy/resources/images/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE10" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<!-- Jquery -->
<script src="${pageContext.request.contextPath}/jgxy/resources/js/jquery-1.11.1.min.js"></script>
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/jgxy/resources/css/bootstrap.min.css" rel="stylesheet">
<!--animate-->
<link href="${pageContext.request.contextPath}/jgxy/resources/css/animate.min.css" rel="stylesheet" type="text/css" />
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/jgxy/resources/js/bootstrap.min.js"></script>

<!--swiper-->

<link href="${pageContext.request.contextPath}/jgxy/resources/css/certify.css" rel="stylesheet" type="text/css" />

<!--index-->
<link href="${pageContext.request.contextPath}/jgxy/resources/css/common.css" rel="stylesheet" type="text/css" />
<link href="${pageContext.request.contextPath}/jgxy/resources/css/index.css" rel="stylesheet" type="text/css" />

<!–[if !IE]><!–> 
<link href="${pageContext.request.contextPath}/jgxy/resources/css/swiper.min.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/jgxy/resources/js/swiper.min.js"></script>
<!–<![endif]–>
<!–[if IE]>
<link rel="stylesheet" href="${pageContext.request.contextPath}/jgxy/resources/css/idangerous.swiper.css">
<script src="${pageContext.request.contextPath}/jgxy/resources/js/idangerous.swiper.min.js"></script>
 <![endif]–>
<style>
	#certify{width: 100% !important;height: 200px;overflow: hidden;}
	#certify .swiper-slide p{display: none !important;}
	#certify .swiper-pagination{display: none !important;}
	#certify .swiper-button-prev{display: none !important;}
	#certify .swiper-button-next{display: none !important;}
	#certify .swiper-slide{height: auto;margin: 0 10px;}
	#certify .swiper-slide img{width: 100%;object-fit: cover;}
	#cxtfdck{border: 1px solid #c0c0c0;margin: 0 auto;padding: 5px;background: #f0f0f0}
	
	@media (min-width:768px) and (max-width:991px){
		.news_list .single_news_wrapper .single_news.hover_before{font-size: 13px;}
		.main_part_1_wrapepr .news_list_wrapper{width:90%;margin: 0 auto 15px;}
		.main_part_2_wrapepr .other_news_list_wrapper{width:90%;margin: 0 auto 15px;}
		.main_part_2_wrapepr .other_news_list_wrapper .col-sm-6{margin-bottom:15px;}
		.main_part_3_wrapepr .right_part_wrapper{width: 90%;margin: 0 auto 15px;}
		.friendship_link_wrapper .friendship_link{padding: 8px 2em;font-size: 14px;}
	}

	
	@media (max-width:767px){
		.news_list .single_news_wrapper .single_news.hover_before{font-size: 13px;}
		.main_part_1_wrapepr .news_list_wrapper{width:90%;margin: 0 auto 15px;}
		.main_part_2_wrapepr .other_news_list_wrapper{width:90%;margin: 0 auto 15px;}
		.main_part_2_wrapepr .other_news_list_wrapper .col-sm-6{margin-bottom:15px;}
		.main_part_3_wrapepr .right_part_wrapper{width: 90%;margin: 0 auto 15px;}
		.friendship_link_wrapper .friendship_link{padding: 8px 2em;font-size: 14px;}
	}
</style>
</head>
<body>
<!-- 浮动广告 div -->
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
				<span id="modalSpan" style="font-size: 25px;word-warp:break-word;word-break:break-all;color: red;font-family: KaiTi;" ></span>
			</div>
			<div class="modal-footer">
				<span id="modalSpan"></span>
			</div>
		</div>
	</div>
</div>


<!-- 校园风采展示 div-->
<div id="schoolDiv" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog  modal-lg">
        <div class="modal-body text-center">
            <a id="schoolA" href="">
                <img id="schoolImg" src="" alt=""  style="width:auto;height:auto;max-width:100%;max-height:100%;"/>
            </a>
            <br>
            <br>
            <span id="schoolSpan" style="font-size: 20px;color: white;word-warp:break-word;word-break:break-all"></span>
        </div>
    </div>
</div>



	<div class="index_wrapper">
		<div class="header">
			<%@ include file="headerJgxy.jsp"%>
		</div>

		<!--main_part_1_wrapepr-->
		<div class="main_part main_part_1_wrapepr clearfix">
			<div class="col-sm-7 banner_wrapper hidden-xs">
				<div id="myCarousel" class="carousel slide">
					<!-- 轮播（Carousel）指标 -->
					<ol class="carousel-indicators">
						<c:forEach items="${jiList}" var="ji" varStatus="status">
							<c:if test="${status.index == 0}">
								<li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
							</c:if>
							<c:if test="${status.index > 0}">
								<li data-target="#myCarousel" data-slide-to="${status.index}"></li>
							</c:if>
						</c:forEach>
					</ol>
					<!-- 轮播（Carousel）项目 -->
					<div class="carousel-inner">
					
					<c:forEach items="${jiList}" var="ji" varStatus="status">
						<c:if test="${status.index == 0}">
							<div class="item active">
								<a href="${ji.imgHref}">
									<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" alt="">
								</a>
							</div>
						</c:if>
						<c:if test="${status.index > 0}">
							<div class="item">
								<a href="${ji.imgHref}">
									<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" alt="">
								</a>
							</div>
						</c:if>
					</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-sm-5 news_list_wrapper">
				<p class="news_list_tittle clearfix">
					<span>学院新闻</span>
					<a href="${ctx}/jgxy/jgxyReception/list" target="_blank" class="more_info_btn pull-right">
						<span>更多</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
					</a>
				</p>
				<ul class="news_list">
					<c:forEach items="${jgxyNoteList}" var="jgxyNote" varStatus="status">
						<li class="single_news_wrapper">
							<a href="${ctx}/jgxy/jgxyReception/get?id=${jgxyNote.id}&add=1" target="_blank" class="single_news hover_before">
								<span class="news_points"></span>
								<span class="news_tittle">${jgxyNote.title}</span> 
								<c:if test="${jgxyNote.newState eq '1'}">
									<span class="news_state">[New]</span> 
								</c:if>
								
								<span class="news_time"><fmt:formatDate value="${jgxyNote.releaseDate}" pattern="yyyy-MM-dd"/></span>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<!--main_part_2_wrapepr-->
		<div class="main_part main_part_2_wrapepr">
			<div class="col-sm-8 other_news_list_wrapper">
				<div class="col-sm-6">
					<div class="other_news_tittle clearfix">
						<span class="other_news_tittle_big">教科研</span>
						<span class="">工作</span>

						<a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=3910232656710862337" target="_blank" class="more_info_btn pull-right">
							<span>更多</span>
							<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
						</a>
					</div>
					<div class="tabs-container">
						<ul class="nav nav-tabs">
							<li class="active">
								<a data-toggle="tab" href="#tab-1" aria-expanded="true">教学动态</a>
							</li>
							<li>
								<a data-toggle="tab" href="#tab-2" aria-expanded="false">科研资讯</a>
							</li>
						</ul>
						<div class="tab-content">
							<div id="tab-1" class="tab-pane active">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteJXDT}" var="jgxyNote" varStatus="status">
											<li class="single_news_wrapper">
												<a href="${ctx}/jgxy/jgxyReception/get?id=${jgxyNote.id}&add=1" target="_blank" class="single_news hover_before">
													<span class="news_points"></span>
													<span class="news_tittle">${jgxyNote.title}</span> 
													<span class="news_time"><fmt:formatDate value="${jgxyNote.releaseDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
									</c:forEach>
								</ul>
							</div>
							<div id="tab-2" class="tab-pane">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteKYZX}" var="jgxyNote" varStatus="status">
										<!-- 这里需要注意,直接用菜单的id做的比较,因为菜单名称有重复的 -->
											<li class="single_news_wrapper">
												<a href="${ctx}/jgxy/jgxyReception/get?id=${jgxyNote.id}&add=1" target="_blank" class="single_news hover_before">
													<span class="news_points"></span>
													<span class="news_tittle">${jgxyNote.title}</span> 
													<span class="news_time"><fmt:formatDate value="${jgxyNote.releaseDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="col-sm-6">
					<div class="other_news_tittle clearfix">
						<span class="other_news_tittle_big">工作</span>
						<span class="">动态</span>

						<a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=8292706150830458832" target="_blank"  class="more_info_btn pull-right">
							<span>更多</span>
							<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
						</a>
					</div>
					<div class="tabs-container">
						<ul class="nav nav-tabs">
							<li class="active">
								<a data-toggle="tab" href="#tab-3" aria-expanded="true">工作信息</a>
							</li>
						</ul>
						<div class="tab-content">
							<div id="tab-3" class="tab-pane active">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteGZXY}" var="jgxyNote" varStatus="status">
											<li class="single_news_wrapper">
												<a href="${ctx}/jgxy/jgxyReception/get?id=${jgxyNote.id}&add=1" target="_blank"  class="single_news hover_before">
													<span class="news_points"></span>
													<span class="news_tittle">${jgxyNote.title}</span> 

													<span class="news_time"><fmt:formatDate value="${jgxyNote.releaseDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-4 other_news_list_wrapper">
				<div class="other_news_tittle clearfix">
					<span class="other_news_tittle_big">通知</span>
					<span class="">公告</span>

					<a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=1105405848443694891" target="_blank" class="more_info_btn pull-right">
						<span>更多</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
					</a>
				</div>
				<div class="col-sm-12">
					<div class="tabs-container">
						<ul class="nav nav-tabs">
						</ul>
						<div class="tab-content">
							<div id="tab-7" class="tab-pane active">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteGSGG}" var="jgxyNote" varStatus="status">
										<!-- 这里需要注意,直接用菜单的id做的比较,因为菜单名称有重复的 -->
											<li class="single_news_wrapper">
												<a href="${ctx}/jgxy/jgxyReception/get?id=${jgxyNote.id}&add=1" target="_blank"  class="single_news hover_before">
													<span class="news_points"></span>
													<span class="news_tittle">${jgxyNote.title}</span> 
													<c:if test="${jgxyNote.newState eq '1'}">
														<span class="news_state">[New]</span> 
													</c:if>
													<span class="news_time"><fmt:formatDate value="${jgxyNote.releaseDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--index_banner_1-->
		<div class="index_banner_wrapper index_banner_wrapper_1">
			<img src="${pageContext.request.contextPath}/jgxy/resources/images/index_banner_1.jpg" alt="" class="index_banner_img" />
		</div>

		<!--main_part_3_wrapepr-->
		<div class="main_part main_part_3_wrapepr">
			<div class="col-sm-4 right_part_wrapper">
				<div class="right_part_tittle">
					<p class="right_part_name">党建工作</p>
					<p class="right_part_tips">Self help query</p>
				</div>
				<div class="friendship_link_wrapper">
				
					<c:forEach items="${jgxyNoteDJGZ}" var="jgxyNote" varStatus="status">
						<a href="${ctx}/jgxy/jgxyReception/get?id=${jgxyNote.id}&add=1" target="_blank"  class="friendship_link">
							${jgxyNote.title}
						</a>
					</c:forEach>
				</div>
			</div>
			<div class="col-sm-4 right_part_wrapper">
				<div class="right_part_tittle">
					<p class="right_part_name">师德师风建设</p>
					<p class="right_part_tips">Self help query</p>
				</div>
				<div class="friendship_link_wrapper">
				
					<c:forEach items="${jgxyNoteXFJS}" var="jgxyNote" varStatus="status">
						<a href="${ctx}/jgxy/jgxyReception/get?id=${jgxyNote.id}&add=1" target="_blank"  class="friendship_link">
							${jgxyNote.title}
						</a>
					</c:forEach>
				</div>
			</div>
			<div class="col-sm-4 right_part_wrapper">
				<div class="right_part_tittle">
					<p class="right_part_name">精品课</p>
				</div>
				<div class="friendship_link_wrapper">
					<img src="${pageContext.request.contextPath}/jgxy/resources/images/jingpinkecheng.jpg" style="width: 100%" alt="" class="icon_more">
				</div>
			</div>
		</div>

		<!--index_banner_2-->
		<div class="index_banner_wrapper c">
			<img src="${pageContext.request.contextPath}/jgxy/resources/images/index_banner_2.jpg" alt="" class="index_banner_img" />
		</div>

		<div class="main_part_4_wrapepr index_banner_wrapper_2 clearfix ">
			<div class="col-sm-12 right_part_wrapper m-b" style="margin-bottom: 15px;">
				<div class="right_part_tittle">
					<p class="right_part_name">校园风采</p>
					<p class="right_part_tips">Self help query</p>
				</div>
			</div>			

			<div id="certify" class="col-sm-12">
			
				
			
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach items="${jiList1}" var="ji" varStatus="status">
							<div class="swiper-slide">
								<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" onclick="showImg('${ji.imgTitle}','${ji.imgPath}')" width="335" height="200" />
							</div>
							<div class="swiper-slide">
								<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" onclick="showImg('${ji.imgTitle}','${ji.imgPath}')" width="335" height="200" />
							</div>
							<div class="swiper-slide">
								<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" onclick="showImg('${ji.imgTitle}','${ji.imgPath}')" width="335" height="200" />
							</div>
						</c:forEach>
					</div>
					<div class="swiper-pagination"></div>
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
				</div>
				
				<div id="certify2" class="carousel slide">					
					<!-- 轮播（Carousel）项目 -->
					<div class="carousel-inner">
					
					<c:forEach items="${jiList1}" var="ji" varStatus="status">
						<c:if test="${status.index == 0}">							
							<div class="item active">
								<a>
									<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" onclick="showImg('${ji.imgTitle}','${ji.imgPath}')" width="335" height="200" />
								</a>
							</div>
						</c:if>
						<c:if test="${status.index > 0}">
							<div class="item">
								<a>
									<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" onclick="showImg('${ji.imgTitle}','${ji.imgPath}')" width="335" height="200" />
								</a>
							</div>
						</c:if>
					</c:forEach>
					</div>
				</div>
				
			</div>
		</div>

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
		//模态广告代码↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
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
		//悬浮广告代码↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑


		// banner
		$('#myCarousel').carousel({
			interval : 5000,
		});
		
		
		
		/*var mySwiper = new Swiper('.swiper-container',{
			autoplay: 3000,
			watchSlidesProgress : true,
			slidesPerView : 'auto',
			centeredSlides : true,
			loop : true,
			loopedSlides : 5,
			autoplay : true,
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},
			pagination : {
				el : '.swiper-pagination',
			},
		}); */
  
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


		// 滑动显示各个部分
		$(window).on('scroll', function() {
			// 滚动动画
			// window_scroll();
		});
		
		if(IEVersion() == -1){
			$('#certify2').remove();			
			var mySwiper = new Swiper('.swiper-container',{
				watchSlidesProgress : true,
				slidesPerView : 'auto',
				centeredSlides : true,
				loop : true,
				loopedSlides : 5,
				autoplay : 3000,
			  });  
		}else{
			$('.swiper-container').remove();
			$('#certify2').carousel({
				interval : 3000,
			});
		}
		
	});

	window.onload = function() {

		// 滚动动画
		// window_scroll();

		// 搜索事件
		$('.search_btn').on('click', function() {
			var search_val = $('.search_input').val();
		});
		

		$('.test').addClass('news_tittle');
	}
	
	// 滚动动画
	function window_scroll() {
		var window_top = $(window).scrollTop();
		$('.main_part_2_wrapepr').css({
			'visibility' : 'visible',
			'animation-name' : 'fadeInUp'
		}).addClass('animated');

		if (window_top >= 10) {
			$('.main_part_2_wrapepr').css({
				'visibility' : 'visible',
				'animation-name' : 'fadeInUp'
			}).addClass('animated');
		}
		if (window_top >= 300) {
			$('.index_banner_wrapper_1').css({
				'visibility' : 'visible',
				'animation-name' : 'fadeInUp'
			}).addClass('animated');
		}

		if (window_top >= 500) {
			$('.main_part_3_wrapepr').css({
				'visibility' : 'visible',
				'animation-name' : 'fadeInUp'
			}).addClass('animated');
		}

		if (window_top >= 600) {
			$('.index_banner_wrapper_2').css({
				'visibility' : 'visible',
				'animation-name' : 'fadeInUp'
			}).addClass('animated');
		}

		if (window_top >= 550) {
			$('.footer').css({
				'visibility' : 'visible',
				'animation-name' : 'fadeInUp'
			}).addClass('animated');
		}
	}
	
	// 1、判断IE浏览器的具体版本
	function IEVersion() {
      var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串  
      var isIE = userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1; //判断是否IE<11浏览器  
      var isEdge = userAgent.indexOf("Edge") > -1 && !isIE; //判断是否IE的Edge浏览器  
      var isIE11 = userAgent.indexOf('Trident') > -1 && userAgent.indexOf("rv:11.0") > -1;
      if(isIE) {
          var reIE = new RegExp("MSIE (\\d+\\.\\d+);");
          reIE.test(userAgent);
          var fIEVersion = parseFloat(RegExp["$1"]);
          if(fIEVersion == 7) {
              return 7;
          } else if(fIEVersion == 8) {
              return 8;
          } else if(fIEVersion == 9) {
              return 9;
          } else if(fIEVersion == 10) {
              return 10;
          } else {
              return 6;//IE版本<=7
          }   
      } else if(isEdge) {
          return 'edge';//edge
      } else if(isIE11) {
          return 11; //IE11  
      }else{
          return -1;//不是ie浏览器
      }
	}
	// 2、判断是否是IE 11及以下或者其他(其他里包括IE edge)
	function isIE() {
		if(!!window.ActiveXObject || "ActiveXObject" in window){
		  return true;
		}else{
		  return false;
	　　 }
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