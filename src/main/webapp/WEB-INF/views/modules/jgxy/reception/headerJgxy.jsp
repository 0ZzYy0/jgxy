<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<div class="head_wrapper clearfix">
    <div class="school_logo_wrapper pull-left clearfix">

        <img src="${pageContext.request.contextPath}/jgxy/resources/images/school_logo3.png" alt="" class="school_logo pull-left">
        <!--<img src="${pageContext.request.contextPath}/jgxy/resources/images/school_logo.png" alt="" class="school_logo pull-left">-->
        <!--<p class="school_name">黑龙江司法警官职业学院</p>-->
        <!--<p class="school_name_second">The Professional Judicial Police College of Heilongjiang</p>-->
        <!--<p class="school_name_tips">司法行政系统所属院校</p>-->
    </div>
    <div class="head_right_wrapper pull-right">
        <div class="right_text_wrapper text-right">
            <span>能</span>
            <span class="big_font">文</span>
            <span class="">能</span>
            <span class="big_font">武</span>
            <!--<span class="big_font">能武</span>-->
            <!--<span class="big_font">又红</span>-->
            <span>又</span>
            <span class="big_font">红</span>
            <span class="">又</span>
            <span class="big_font">专</span>
        </div>
        <!--<div class="right_text_wrapper_2">UNITY INTEGRITY</div>-->
        <!--<div class="right_text_wrapper_2">WE CAN DO BETTER</div>-->
        <div class="right_text_wrapper_3">Practical Idea of Running Schools</div>
        <div class="right_text_wrapper_4">切合实际的办学理念</div>
        <!--<div class="right_text_wrapper_4">又红又专</div>-->
        <div class="search_wrapper">
            <!--<span class="search_text">局内搜索：</span>-->
            <input id="jnsc" type="text" class="search_input form-control" placeholder="局内搜索"/>
            <a href="javascript:void(0);" onclick="toList()" class="search_btn">
                <img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_search.png" alt="" class="search_img"/>
            </a>    
        </div>
    </div>
</div>

<div class="nav_fixed_wrapper">
    <div class="nav_wrapper">
        <ul class="nav_ul clearfix">
            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/index">
                    <span class="nav_name">首页</span>
                    <span class="nav_tips">Index</span>
                </a>
            </li>
            <li class="nav_ul_li">
            	<!-- 学院概况直接跳转详情,写死了文章的id -->
                <a href="${ctx}/jgxy/jgxyReception/get?id=6100105655406495785">
                    <span class="nav_name">学院概况</span>
                    <span class="nav_tips">College</span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="http://www.hljsfjy.org.cn/zs/index_zs.php" target="_blank">
                    <span class="nav_name">招生网</span>
                    <span class="nav_tips">Supply</span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="http://www.hljsfjy.org.cn/jy/index_jy.php" target="_blank">
                    <span class="nav_name">就业网</span>
                    <span class="nav_tips">Jobs</span>
                </a>
            </li>


            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=3946981313027664138">
                    <span class="nav_name">学风建设</span>
                    <span class="nav_tips">Build</span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=7868304688644257636">
                    <span class="nav_name">信息公开</span>
                    <span class="nav_tips">Info</span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="javascript:void(0);">
                    <span class="nav_name">继续教育</span>
                    <span class="nav_tips">Education</span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=8292706150830458832">
                    <span class="nav_name">工作动态</span>
                    <span class="nav_tips">Dynamic</span>
                </a>
            </li>
            <!--<li class="nav_ul_li">-->
                <!--<a href="javascript:void(0);">-->
                    <!--<span class="nav_name">培训中心</span>-->
                    <!--<span class="nav_tips">Dynamic</span>-->
                <!--</a>-->
            <!--</li>-->
        </ul>
    </div>
</div>

<script type="text/javascript">
var cctx = "${ctx}";
function toList(){
	var title = $("#jnsc").val();
	//console.log(title);
	window.location.href=cctx+"/jgxy/jgxyReception/list?jgxyNoteTitle="+encodeURI(title);//encodeURIComponent(title)
}

</script>
