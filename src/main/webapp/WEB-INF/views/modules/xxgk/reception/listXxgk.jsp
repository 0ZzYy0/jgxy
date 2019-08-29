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

<link href="${pageContext.request.contextPath}/jgxy/resources/datatables/dataTables.bootstrap.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/jgxy/resources/datatables/jquery.dataTables.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/jgxy/resources/datatables/dataTables.bootstrap.min.js" type="text/javascript"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/jgxy/resources/AdminLTE/ionicons.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/jgxy/resources/AdminLTE/jquery-jvectormap.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/jgxy/resources/AdminLTE/AdminLTE.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/jgxy/resources/AdminLTE/_all-skins.min.css">

<style>
.news_list_wrapper{padding: 15px;background: #fff;}
.news_list_wrapper .news_list_tittle{color: #d03539;font-size: 22px;border-bottom: 1px dashed #d2d2d2;padding-bottom: 15px;margin-bottom: 15px;}
/*news_list_1*/.news_list_1{margin-bottom: 15px;}
.news_list_1 .news_list{}
.news_list_1 .news_list .single_news_wrapper{}
.news_list_1 .news_list .single_news_wrapper .single_news{margin: 8px;}
.news_list_1 .news_list .single_news_wrapper .single_news .news_points{position: relative;display: flex;justify-items: center;align-items: center;padding: 0 10px;}
.news_list_1 .news_list .single_news_wrapper .single_news .news_points:before{content: '';color: #000000;width: 6px;height: 6px;background: #969694;display: block;border-radius: 50%;}
.news_list_1 .news_list .single_news_wrapper .single_news .news_tittle{color: #000000;overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 1;flex: 2;}
.news_list_1 .news_list .single_news_wrapper .single_news .news_text{color: #969694;overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 2;}
.news_list_1 .news_list .single_news_wrapper .single_news .news_state{color: #d03539;}
.news_list_1 .news_list .single_news_wrapper .single_news .news_img{display: none;float: left;width: 100px;height: 64px;margin-right: 15px;}
.news_list_1 .news_list .single_news_wrapper .single_news .news_time{/*color: #969694;*/margin-left: 5px;width: 80px;text-align: center;}
/*hover_before*/.news_list_1 .news_list .single_news_wrapper .single_news.hover_before{display: flex;font-size: 14px;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_before{color: #969694;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_before:hover{color: #0b4782;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_before:hover .news_tittle{color: #0b4782;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_before .news_text{display: none;}
/*hover_this*/.news_list_1 .news_list .single_news_wrapper .single_news.hover_this .news_img{display: block;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_this{display: block;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_this:before{content: '';display: table;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_this:after{content: '';clear: both;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_this .news_tittle{color: #000;font-size: 16px;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_this .news_points{display: none;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_this .news_state{float: right;margin-left: 10px;}
.news_list_1 .news_list .single_news_wrapper .single_news.hover_this .news_time{width: 100%;display: block;text-align: right;}
/*news_info*/.news_info{margin-bottom: 15px;}
.news_info .news_list{}
.news_info .news_list .single_news_wrapper{}
.news_info .news_list .single_news_wrapper .single_news{margin: 8px;}
.news_info .news_list .single_news_wrapper .single_news .news_points{position: relative;display: flex;justify-items: center;align-items: center;padding: 0 10px;}
.news_info .news_list .single_news_wrapper .single_news .news_points:before{content: '';color: #000000;width: 6px;height: 6px;background: #969694;display: block;border-radius: 50%;}
.news_info .news_list .single_news_wrapper .single_news .news_tittle{color: #000000;text-align: center;font-size: 20px;margin-bottom: 15px;display: block;}
.news_info .news_list .single_news_wrapper .single_news .news_text{color: #969694;overflow: hidden;text-overflow: ellipsis;display: -webkit-box;-webkit-box-orient: vertical;-webkit-line-clamp: 2;}
.news_info .news_list .single_news_wrapper .single_news .news_state{color: #d03539;}
.news_info .news_list .single_news_wrapper .single_news .news_img{display: none;float: left;width: 100px;height: 64px;margin-right: 15px;}
.news_info .news_list .single_news_wrapper .single_news .news_time{width: 100%;text-align: center;margin-bottom: 15px;font-size: 14px;color: #808080;}
.news_info .news_list .single_news_wrapper .single_news .news_tips{width: 100%;text-align: center;font-size: 16px;margin-bottom: 10px;color: #808080;}
.news_info .news_info .news_list .single_news_wrapper .single_news .news_content{width: 100%;text-align: left;text-indent: 2em;font-size: 16px;}
/*hover_before*/.news_info .news_list .single_news_wrapper .single_news.hover_before{display: flex;font-size: 14px;}
.news_info .news_list .single_news_wrapper .single_news.hover_before{color: #969694;}
.news_info .news_list .single_news_wrapper .single_news.hover_before:hover{color: #0b4782;}
.news_info .news_list .single_news_wrapper .single_news.hover_before:hover .news_tittle{color: #0b4782;}
.news_info .news_list .single_news_wrapper .single_news.hover_before .news_text{display: none;}
/*hover_this*/.news_list .single_news_wrapper .single_news.hover_this .news_img{display: block;}
.news_list .single_news_wrapper .single_news.hover_this{display: block;}
.news_list .single_news_wrapper .single_news.hover_this:before{content: '';display: table;}
.news_list .single_news_wrapper .single_news.hover_this:after{content: '';clear: both;}
.news_list .single_news_wrapper .single_news.hover_this .news_tittle{color: #000;font-size: 16px;}
.news_list .single_news_wrapper .single_news.hover_this .news_points{display: none;}
.news_list .single_news_wrapper .single_news.hover_this .news_state{float: right;margin-left: 10px;}
.news_list .single_news_wrapper .single_news.hover_this .news_time{width: 100%;display: block;text-align: right;}
.friendship_link_content{}
.friendship_link_content .friendship_link_ul{margin-left: 2em;}
.friendship_link_content .friendship_link_ul .friendship_link_li{}
.friendship_link_content .friendship_link_ul .friendship_link_li .friendship_link:hover{color: #fff;}
.friendship_link_content .friendship_link_ul .friendship_link_li:last-child .friendship_link{border-bottom: none;}
.friendship_link_content .friendship_link_ul .friendship_link_li .friendship_link{margin-left: 2em;color: #808080;border-bottom: none;padding: 6px 0;text-indent: 1em;}
/*selfHelp_query_wrapper*/.selfHelp_query_wrapper{}
.selfHelp_query_wrapper .selfHelp_query_content{}
.selfHelp_query_wrapper .selfHelp_query_content .selfHelp_query_ul{margin-left: 2em;}
.selfHelp_query_wrapper .selfHelp_query_content .selfHelp_query_ul .selfHelp_query_li{}
.selfHelp_query_wrapper .selfHelp_query_content .selfHelp_query_ul .selfHelp_query_li .selfHelp_query{margin-left: 2em;}
a:link{color:black;}
a:hover{color:blue;}
.friendship_link_wrapper{height:92%;}
.news_content img{width:90%;display:block;margin:0 auto;}
	@media (min-width:768px) and (max-width:991px){
		.xxgk_right_part_wrapper{
			width: 90%;
			padding: 0;
			margin: 0 auto 15px;
		}
		.main_part_1_wrapepr {
			flex-wrap: wrap;
		}
		.main_part_1_wrapepr .xxgk_right_part_wrapper{
			width: 100%;
			margin-bottom: 15px;
		}
		.main_part_1_wrapepr .xxgk_right2_part_wrapper{width:100%;}
		.friendship_link_wrapper{height:auto;}
		.news_list_wrapper{
			width: 90%;
			margin: 10px auto;
		}
	}
	@media (max-width:767px){
		.xxgk_right_part_wrapper{
			width: 90%;
			padding: 0;
			margin: 0 auto 15px;
		}
		.main_part_3_wrapepr>.col-sm-4{
			width: 90%;
			padding: 0;
			margin: 0 auto;
		}
		.main_part_1_wrapepr {
			flex-wrap: wrap;
		}
		.main_part_1_wrapepr .xxgk_right_part_wrapper{
			width: 100%;
			margin-bottom: 15px;
		}
		.main_part_1_wrapepr .xxgk_right2_part_wrapper{width:100%;}
		.friendship_link_wrapper{height:auto;}
		.news_list_wrapper{
			width: 90%;
			margin: 10px auto;
		}
	}
</style>
</head>
<body>
    <!--<div class="index_bg"></div>-->
    <!--<img src="${pageContext.request.contextPath}/jgxy/resources/images/index_bg3.jpg" alt="" class="index_bg" draggable="false"/>-->
    <div class="index_wrapper">
        <div class="header">
            <%@ include file="headerXxgk.jsp"%>
        </div>

        <!--main_part_3_wrapepr-->
        <div class="main_part main_part_3_wrapepr">
            <div class="col-sm-3 xxgk_right_part_wrapper">
                <div class="right_part_tittle">
                    <p class="right_part_name">信息公开</p>
                </div>
                <div class="friendship_link_wrapper" >
                    <c:forEach items="${liftXxgkSysMenuList}" var="xxgkSysMenu" varStatus="status">
                       <a href="${ctx}/xxgk/xxgkReception/buttonList?xxgkSysMenuId=${xxgkSysMenu.id}" class="friendship_link">${xxgkSysMenu.name} </a>
                    </c:forEach>
                </div>
            </div>
            <div class="col-sm-9 news_list_wrapper">
                <!--新闻列表-->
                <c:if test="${xxgkNoteList ne null }">
                    <div class="news_list_1" id="jgxyNoteListDiv">
                        <p class="news_list_tittle clearfix" style="text-align: center">
                            <span>${xxgkSysMenuName}</span>
                        </p>
                        <table id="table1" class="table no-margin">
                            <thead>
                                <tr class="row">
                                    <td></td>
                                    <td></td>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${xxgkNoteList}" var="xxgkNote">
                                    <tr class="row">
                                        <td class="col-sm-9">
                                            <a href="${ctx}/xxgk/xxgkReception/get?id=${xxgkNote.id}&add=1" class="single_news hover_before">
                                                <c:if test="${fn:length(xxgkNote.title) gt 20}">
                                                    <span class="news_tittle" title="${xxgkNote.title}">${fn:substring(xxgkNote.title, 0, 20)}...</span> 
                                                </c:if>
                                                <c:if test="${fn:length(xxgkNote.title) le 20}">
                                                    <span class="news_tittle">${xxgkNote.title}</span> 
                                                </c:if>
                                            </a>
                                        </td>
                                        <td class="col-sm-3">
                                            <span class="label label-info"><fmt:formatDate value="${xxgkNote.releaseDate}" pattern="yyyy-MM-dd"/></span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
                <!--新闻详情-->
                <c:if test="${xxgkNote ne null }">
                    <div class="news_info" id="jgxyNoteInfoDiv">
                        <p class="news_list_tittle clearfix" style="text-align: center">
                            <span>${xxgkNote.xxgkSysMenu.name}</span>
                        </p>
                        <ul class="news_list">
                            <li class="single_news_wrapper">
                                <div href="javascript:void(0);" class="single_news">
                                    <div class="news_tittle" id="jgxyNoteTitle">${xxgkNote.title}</div>
                                    <div class="news_time" id="jgxyNotereleaseDate">
										发布日期 : <fmt:formatDate value="${xxgkNote.releaseDate}" pattern="yyyy-MM-dd"/>&nbsp&nbsp&nbsp&nbsp浏览次数 : ${xxgkNote.clickThroughput}
                                    </div>
                                    <div class="news_content">
                                        <p class="form-control-static" id="jgxyNoteContents">${xxgkNote.contents}</p>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </c:if>
            </div>
        </div>

        </br></br>
        <div class="footer">
            <%@ include file="footerJgxy.jsp"%>
        </div>
    </div>
    <!-- /index_wrapper -->
</body>
<script type="text/javascript" src="${pageContext.request.contextPath}/jgxy/resources/js/common.js"></script>
<script type="text/javascript">
    $(function() {

        // 学院新闻
        /*$('.news_list .single_news_wrapper a.single_news').hover(function (e) {
            $(this).removeClass('hover_before').addClass('hover_this');
        },function (e) {
         $(this).removeClass('hover_this').addClass('hover_before');
        });*/
        // 友情链接 点击展开或收起
        $('.friendship_link_content>.friendship_link').on(
                'click',
                function() {
                    var this_ = $(this), sib_ul = this_
                            .siblings('.friendship_link_ul');
                    li_length = sib_ul.find('li').length, p_sib = this_
                            .parents('.friendship_link_content').siblings(
                                    '.friendship_link_content');
                    p_sib.find('.friendship_link_ul').addClass('hide');
                    if (sib_ul.hasClass('hide')) {
                        sib_ul.removeClass('hide');
                    } else {
                        sib_ul.addClass('hide');
                    }
                });
        $('#table1').DataTable({
            "lengthChange": false,
            "searching": false,
            "ordering": false,
            "info": false,
            "autoWidth": false,
            language: {
                zeroRecords: "<div class='text-center'>没有找到相关内容</div>",
                search: "快速搜索："
            },
            "oLanguage":{
                "sLengthMenu": "每页显示 _MENU_条",
                "sZeroRecords": "没有找到符合条件的数据",
                "sProcessing": "加载中...",
                "sInfo": "当前第 _START_ - _END_ 条　共计 _TOTAL_ 条",
                "sInfoEmpty": "没有记录",
                "sInfoFiltered": "(从 _MAX_ 条记录中过滤)",
                "sSearch": "搜索：",
                "oPaginate": {
                        "sFirst": "首页",
                        "sPrevious": "前一页",
                        "sNext": "后一页",
                        "sLast": "尾页"
                    }
                }
        });
    });

    window.onload = function() {

        // 搜索事件
        $('.search_btn').on('click', function() {
            var search_val = $('.search_input').val();
            console.log(search_val);
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
    
    function showInfo(id){

    }
</script>
</html>