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
#certify {
	width: 100% !important;
	height: 310px;
}

#certify .swiper-slide p {
	display: none !important;
}

#certify .swiper-pagination {
	display: none !important;
}

#certify .swiper-button-prev {
	display: none !important;
}

#certify .swiper-button-next {
	display: none !important;
}
</style>
</head>
<body>


	<!--<div class="index_bg"></div>-->
	<!--<img src="${pageContext.request.contextPath}/jgxy/resources/images/index_bg3.jpg" alt="" class="index_bg" draggable="false"/>-->
	<div class="index_wrapper">
		<!--header.html 头部-->
		<!--<#include "/headerJgxy.html">-->

		<div class="header">
			<%@ include file="headerJgxy.jsp"%>
		</div>

		<!--main_part_1_wrapepr-->
		<div class="main_part main_part_1_wrapepr clearfix fadeInUp" style="visibility: hidden; animation-name: none; margin-top: 0px;">
			<div class="col-sm-7 banner_wrapper">
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
								<a href="javascript:void(0);">
									<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" alt="">
								</a>
							</div>
						</c:if>
						<c:if test="${status.index > 0}">
							<div class="item">
								<a href="javascript:void(0);">
									<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" alt="">
								</a>
							</div>
						</c:if>
					</c:forEach>
						<!-- <div class="item active">
							<a href="javascript:void(0);">
								<img src="${pageContext.request.contextPath}/jgxy/resources/images/banner_img_1.jpg" alt="First slide">
								<div class="carousel-caption">优美的校园环境  完善的教学设施  雄厚的师资力量  独具一格的涉警专业</div>
							</a>
						</div> -->
					</div>
				</div>
			</div>
			<div class="col-sm-5 news_list_wrapper">
				<p class="news_list_tittle clearfix">
					<span>学院新闻</span>
					<a href="${ctx}/jgxy/jgxyReception/list" class="more_info_btn pull-right">
						<span>更多</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
					</a>
				</p>
				<ul class="news_list">
					<c:forEach items="${jgxyNoteList}" var="jgxyNote" varStatus="status">
						<li class="single_news_wrapper">
							<a href="javascript:void(0);" class="single_news hover_before">
								<span class="news_points"></span>
								<c:if test="${fn:length(jgxyNote.title) gt 10}">
									<span class="news_tittle">${fn:substring(jgxyNote.title, 0, 10)}...</span> 
								</c:if>
								<c:if test="${fn:length(jgxyNote.title) le 10}">
									<span class="news_tittle">${jgxyNote.title}</span> 
								</c:if>
								<c:if test="${status.index lt 3}">
									<span class="news_state">[New]</span> 
								</c:if>
								<span class="news_time"><fmt:formatDate value="${jgxyNote.createDate}" pattern="yyyy-MM-dd"/></span>
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</div>

		<!--main_part_2_wrapepr-->
		<div class="main_part main_part_2_wrapepr fadeInUp" style="visibility: hidden; animation-name: none;">
			<div class="col-sm-8 other_news_list_wrapper">
				<div class="col-sm-6">
					<div class="other_news_tittle clearfix">
						<span class="other_news_tittle_big">教科研</span>
						<span class="">工作</span>

						<a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=3910232656710862337" class="more_info_btn pull-right">
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
									<c:forEach items="${jgxyNoteList}" var="jgxyNote" varStatus="status">
										<!-- 这里需要注意,直接用菜单的id做的比较,因为菜单名称有重复的 -->
										<c:if test="${jgxyNote.jgxySysMenu.id eq '71864634419527302'}">
											<li class="single_news_wrapper">
												<a href="javascript:void(0);" class="single_news hover_before">
													<span class="news_points"></span>
													<c:if test="${fn:length(jgxyNote.title) gt 10}">
														<span class="news_tittle">${fn:substring(jgxyNote.title, 0, 10)}...</span> 
													</c:if>
													<c:if test="${fn:length(jgxyNote.title) le 10}">
														<span class="news_tittle">${jgxyNote.title}</span> 
													</c:if>
													<span class="news_time"><fmt:formatDate value="${jgxyNote.createDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<div id="tab-2" class="tab-pane">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteList}" var="jgxyNote" varStatus="status">
										<!-- 这里需要注意,直接用菜单的id做的比较,因为菜单名称有重复的 -->
										<c:if test="${jgxyNote.jgxySysMenu.id eq '1517093218844555186'}">
											<li class="single_news_wrapper">
												<a href="javascript:void(0);" class="single_news hover_before">
													<span class="news_points"></span>
													<c:if test="${fn:length(jgxyNote.title) gt 10}">
														<span class="news_tittle">${fn:substring(jgxyNote.title, 0, 10)}...</span> 
													</c:if>
													<c:if test="${fn:length(jgxyNote.title) le 10}">
														<span class="news_tittle">${jgxyNote.title}</span> 
													</c:if>
													<span class="news_time"><fmt:formatDate value="${jgxyNote.createDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
										</c:if>
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

						<a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=8292706150830458832" class="more_info_btn pull-right">
							<span>更多</span>
							<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
						</a>
					</div>
					<div class="tabs-container">
						<ul class="nav nav-tabs">
							<li class="active">
								<a data-toggle="tab" href="#tab-3" aria-expanded="true">工作新闻</a>
							</li>
						</ul>
						<div class="tab-content">
							<div id="tab-3" class="tab-pane active">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteList}" var="jgxyNote" varStatus="status">
										<!-- 这里需要注意,直接用菜单的id做的比较,因为菜单名称有重复的 -->
										<c:if test="${jgxyNote.jgxySysMenu.id eq '2664446703223844603'}">
											<li class="single_news_wrapper">
												<a href="javascript:void(0);" class="single_news hover_before">
													<span class="news_points"></span>
													<c:if test="${fn:length(jgxyNote.title) gt 10}">
														<span class="news_tittle">${fn:substring(jgxyNote.title, 0, 10)}...</span> 
													</c:if>
													<c:if test="${fn:length(jgxyNote.title) le 10}">
														<span class="news_tittle">${jgxyNote.title}</span> 
													</c:if>

													<span class="news_time"><fmt:formatDate value="${jgxyNote.createDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<!--  <div id="tab-4" class="tab-pane">
                                    <ul class="news_list">

                                    </ul>
                                </div>-->
						</div>
					</div>
				</div>
			</div>
			<div class="col-sm-4 other_news_list_wrapper">
				<div class="other_news_tittle clearfix">
					<span class="other_news_tittle_big">通知</span>
					<span class="">公告</span>

					<a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=1105405848443694891" class="more_info_btn pull-right">
						<span>更多</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="more_info_img">
					</a>
				</div>
				<div class="col-sm-12">
					<div class="tabs-container">
						<ul class="nav nav-tabs">
							<li class="active">
								<a data-toggle="tab" href="#tab-6" aria-expanded="true">信息公开</a>
							</li>
							<li>
								<a data-toggle="tab" href="#tab-7" aria-expanded="false">公示公告</a>
							</li>
							<!-- <li>
                                    <a data-toggle="tab" href="#tab-8" aria-expanded="false">简章下载</a>
                                </li> -->
						</ul>
						<div class="tab-content">
							<div id="tab-6" class="tab-pane active">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteList}" var="jgxyNote" varStatus="status">
										<!-- 这里需要注意,直接用菜单的id做的比较,因为菜单名称有重复的 -->
										<c:if test="${jgxyNote.jgxySysMenu.id eq '7868304688644257636'}">
											<li class="single_news_wrapper">
												<a href="javascript:void(0);" class="single_news hover_before">
													<span class="news_points"></span>
													<c:if test="${fn:length(jgxyNote.title) gt 10}">
														<span class="news_tittle">${fn:substring(jgxyNote.title, 0, 10)}...</span> 
													</c:if>
													<c:if test="${fn:length(jgxyNote.title) le 10}">
														<span class="news_tittle">${jgxyNote.title}</span> 
													</c:if>
													<span class="news_time"><fmt:formatDate value="${jgxyNote.createDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<div id="tab-7" class="tab-pane">
								<ul class="news_list">
									<c:forEach items="${jgxyNoteList}" var="jgxyNote" varStatus="status">
										<!-- 这里需要注意,直接用菜单的id做的比较,因为菜单名称有重复的 -->
										<c:if test="${jgxyNote.jgxySysMenu.id eq '1406319674601422774'}">
											<li class="single_news_wrapper">
												<a href="javascript:void(0);" class="single_news hover_before">
													<span class="news_points"></span>
													<c:if test="${fn:length(jgxyNote.title) gt 10}">
														<span class="news_tittle">${fn:substring(jgxyNote.title, 0, 10)}...</span> 
													</c:if>
													<c:if test="${fn:length(jgxyNote.title) le 10}">
														<span class="news_tittle">${jgxyNote.title}</span> 
													</c:if>
													<span class="news_time"><fmt:formatDate value="${jgxyNote.createDate}" pattern="yyyy-MM-dd"/></span>
												</a>
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<!-- <div id="tab-8" class="tab-pane">
                                    <ul class="news_list">
                                        
                                    </ul>
                                </div>-->
						</div>
					</div>
				</div>
				<!--  <div class="right_part_tittle">
                        <p class="right_part_name">友情链接</p>
                        <p class="right_part_tips">Friendship link</p>
                    </div>
                    <div class="friendship_link_wrapper">
                        <a href="javascript:void(0);" class="friendship_link">黑龙江省司法厅</a>
                        <a href="javascript:void(0);" class="friendship_link">教育部阳光高考信息平台</a>
                        <a href="javascript:void(0);" class="friendship_link">黑龙江政法管理干部学院</a>
                        <a href="javascript:void(0);" class="friendship_link">黑龙江招生考试信息港</a>
                        <a href="javascript:void(0);" class="friendship_link">职业技术网</a>
                        <a href="javascript:void(0);" class="friendship_link">培训网</a>
                        <a href="javascript:void(0);" class="friendship_link">就业网</a>
                        <a href="javascript:void(0);" class="friendship_link">办公网</a>
                    </div>-->
			</div>
		</div>

		<!--index_banner_1-->
		<div class="index_banner_wrapper index_banner_wrapper_1 fadeInUp" style="visibility: hidden; animation-name: none;">
			<img src="${pageContext.request.contextPath}/jgxy/resources/images/index_banner_1.jpg" alt="" class="index_banner_img" />
		</div>

		<!--main_part_3_wrapepr-->
		<div class="main_part main_part_3_wrapepr fadeInUp" style="visibility: hidden; animation-name: none;">
			<div class="col-sm-4 quick_access_wrapper other_news_list_wrapper">
				<div class="other_news_tittle">
					<span class="other_news_tittle_big">快速</span>
					<span class="">入口</span>
				</div>

				<div class="quick_access_btn_wrapper clearfix">
					<a href="javascript:void(0);" class="quick_access_btn clearfix">
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/shortcut_icon_1.png" alt="" class="quick_access_btn_img">
						<span class="quick_access_btn_text">校园风采</span>
					</a>
					<a href="javascript:void(0);" class="quick_access_btn clearfix">
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/shortcut_icon_2.png" alt="" class="quick_access_btn_img">
						<span class="quick_access_btn_text">校园视频</span>
					</a>
					<a href="http://www.hljsfjy.org.cn/zs/search.php" target="_blank" class="quick_access_btn clearfix">
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/shortcut_icon_3.png" alt="" class="quick_access_btn_img">
						<span class="quick_access_btn_text">录取查询</span>
					</a>

					<a href="http://www.hljsfjy.org.cn/zs/xz_mx.php?id=98" target="_blank" class="quick_access_btn clearfix">
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/shortcut_icon_4.png" alt="" class="quick_access_btn_img">
						<span class="quick_access_btn_text">简章下载</span>
					</a>
					<a href="http://www.hljsfjy.org.cn/zs/jh.php" target="_blank" class="quick_access_btn clearfix">
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/shortcut_icon_5.png" alt="" class="quick_access_btn_img">
						<span class="quick_access_btn_text">招生计划</span>
					</a>
					<a href="javascript:void(0);" class="quick_access_btn clearfix">
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/shortcut_icon_6.png" alt="" class="quick_access_btn_img">
						<span class="quick_access_btn_text">继续教育</span>
					</a>

				</div>
			</div>
			<div class="col-sm-4 right_part_wrapper">
				<div class="right_part_tittle">
					<p class="right_part_name">友情链接</p>
				</div>
				<div class="friendship_link_wrapper">
					<a href="http://www.hljsf.gov.cn/" target="_blank" class="friendship_link">黑龙江省司法厅</a>
					<a href="https://gaokao.chsi.com.cn/" target="_blank" class="friendship_link">教育部阳光高考信息平台</a>
					<a href="http://www.hljzfxy.org.cn/" target="_blank" class="friendship_link">黑龙江政法管理干部学院</a>
					<a href="https://www.lzk.hl.cn/" target="_blank" class="friendship_link">黑龙江招生考试信息港</a>
				</div>
			</div>
			<div class="col-sm-4 right_part_wrapper">

				<div class="right_part_tittle">
					<p class="right_part_name">自助查询</p>
					<p class="right_part_tips">Self help query</p>
				</div>


				<div class="selfHelp_query_wrapper">
					<a href="http://www.hljsfjy.org.cn/zs/news.php?nclass=%D7%A8%C9%FD%B1%BE" target="_blank" class="selfHelp_query clearfix">
						<span class="selfHelp_query_text">专升本</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="icon_more">
					</a>
					<a href="http://www.hljsfjy.org.cn/zs/zyjs.php" target="_blank" class="selfHelp_query clearfix">
						<span>专业介绍</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="icon_more">
					</a>
					<a href="http://www.hljsfjy.org.cn/dz/index.php" target="_blank" class="selfHelp_query clearfix">
						<span>单独招生</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="icon_more">
					</a>
					<a href="http://www.hljsfjy.org.cn/zs/answer.php?nclass=%BF%BC%C9%FA%CE%CA%B4%F0" target="_blank" class="selfHelp_query clearfix">
						<span>在线咨询</span>
						<img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_more.png" alt="" class="icon_more">
					</a>
				</div>
			</div>
		</div>

		<!--index_banner_2-->
		<div class="index_banner_wrapper c fadeInUp hide" style="visibility: hidden; animation-name: none;">
			<img src="${pageContext.request.contextPath}/jgxy/resources/images/index_banner_2.jpg" alt="" class="index_banner_img" />
		</div>

		<div class="main_part_4_wrapepr index_banner_wrapper_2 clearfix " style="visibility: hidden; animation-name: none;">
			<div class="col-sm-12 right_part_wrapper m-b" style="margin-bottom: 15px;">
				<div class="right_part_tittle">
					<p class="right_part_name">校园风采</p>
					<p class="right_part_tips">Self help query</p>
				</div>
			</div>
			<div id="certify" class="col-sm-12 fadeInUp">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:forEach items="${jiList1}" var="ji" varStatus="status">
							<div class="swiper-slide">
								<img src="http://${pageContext.request.serverName}:${pageContext.request.serverPort}${ji.imgPath}" width="520" height="310" />
								<!-- <p class="">非常难得又值钱的认证证书</p> -->
							</div>
					</c:forEach>
					</div>
				</div>
				<div class="swiper-pagination"></div>
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
			</div>
		</div>


		<!--footer.html 底部-->
		<!--<#include "/footerJgxy.html">-->

		<div class="footer">
			<%@ include file="footerJgxy.jsp"%>
		</div>
	</div>
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/jgxy/resources/js/common.js"></script>
<script type="text/javascript">
	// 滚动动画
	function window_scroll() {
		var window_top = $(window).scrollTop();
		$('.main_part_1_wrapepr,.header,.main_part_2_wrapepr').css({
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
	$(function() {
		// 请求头部字符串 公共部分
		header_str();

		// 请求底部字符串 公共部分
		footer_str();

		// banner
		$('#myCarousel').carousel({
			interval : 5000,
		});

		// 学院新闻
		/*$('.news_list .single_news_wrapper a.single_news').hover(function (e) {
		    $(this).removeClass('hover_before').addClass('hover_this');
		},function (e) {
		 $(this).removeClass('hover_this').addClass('hover_before');
		});*/

		// 滑动显示各个部分
		$(window).on('scroll', function() {
			// 滚动动画
			window_scroll();
		});

		certifySwiper = new Swiper(
				'#certify .swiper-container',
				{
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
					//clickable :true,
					},
					on : {
						progress : function(progress) {
							for (i = 0; i < this.slides.length; i++) {
								var slide = this.slides.eq(i);
								var slideProgress = this.slides[i].progress;
								modify = 1;
								if (Math.abs(slideProgress) > 1) {
									modify = (Math.abs(slideProgress) - 1) * 0.3 + 1;
								}
								translate = slideProgress * modify * 260 + 'px';
								scale = 1 - Math.abs(slideProgress) / 5;
								zIndex = 999 - Math.abs(Math
										.round(10 * slideProgress));
								slide.transform('translateX(' + translate
										+ ') scale(' + scale + ')');
								slide.css('zIndex', zIndex);
								slide.css('opacity', 1);
								if (Math.abs(slideProgress) > 3) {
									slide.css('opacity', 0);
								}
							}
						},
						setTransition : function(transition) {
							for ( var i = 0; i < this.slides.length; i++) {
								var slide = this.slides.eq(i)
								slide.transition(transition);
							}

						}
					}

				});
	});

	window.onload = function() {
/*          $.ajax({
            url : "${ctx}/jgxy/jgxyReception/getNote",
            type : "POST",
            async : true,//或false,是否异步
            dataType : 'json',
            success : function(data) {
                alert(data);
            },
            error : function() {
                alert("出错");
            }
        }); */
		// 滚动动画
		window_scroll();

		// 搜索事件
		$('.search_btn').on('click', function() {
			var search_val = $('.search_input').val();
			console.log(search_val);
			console.log("-------");
			// $.ajax({
			//     url : "header.html",
			//     type : "POST",
			//     data : {},
			//     success : function(data){
			//         console.log(data);
			//     },
			// });
		});
	}
</script>
</html>