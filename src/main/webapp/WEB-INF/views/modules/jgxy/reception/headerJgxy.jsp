<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>  
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<div class="head_wrapper clearfix">
    <div class="school_logo_wrapper pull-left clearfix">

        <img src="${pageContext.request.contextPath}/jgxy/resources/images/school_logo4.png" alt="" class="school_logo pull-left">
        <!--<img src="${pageContext.request.contextPath}/jgxy/resources/images/school_logo.png" alt="" class="school_logo pull-left">-->
        <!--<p class="school_name">黑龙江司法警官职业学院</p>-->
        <!--<p class="school_name_second">The Professional Judicial Police College of Heilongjiang</p>-->
        <!--<p class="school_name_tips">司法行政系统所属院校</p>-->
    </div>
    <div class="head_right_wrapper pull-right">
        <div class="right_text_wrapper text-right hidden-xs">
			<img src="${pageContext.request.contextPath}/jgxy/resources/images/top_right.png" alt="" class=""/>
            <!--<span>能</span>
            <span class="big_font">文</span>
            <span class="">能</span>
            <span class="big_font">武</span>-->
            <!--<span class="big_font">能武</span>-->
            <!--<span class="big_font">又红</span>-->
            <!--<span>又</span>
            <span class="big_font" style="color: red">红</span>
            <span class="">又</span>
            <span class="big_font">专</span>-->
        </div>
        <!--<div class="right_text_wrapper_2">UNITY INTEGRITY</div>-->
        <!--<div class="right_text_wrapper_2">WE CAN DO BETTER</div>-->
        <!--<div class="right_text_wrapper_3 hidden-xs">Practical Idea of Running Schools</div>
        <div class="right_text_wrapper_4 hidden-xs">切合实际的办学理念</div>-->
        <!--<div class="right_text_wrapper_4">又红又专</div>-->
        <div class="search_wrapper">
            <input id="jnsc" type="text" class="search_input form-control" placeholder="站内搜索"/>
            <a href="javascript:void(0);" onclick="toList()" class="search_btn">
                <img src="${pageContext.request.contextPath}/jgxy/resources/images/icon_search.png" alt="" class="search_img"/>
            </a>    
        </div>
    </div>
</div>

<div class="nav_fixed_wrapper">
    <div class="nav_wrapper">
		<img src="${pageContext.request.contextPath}/jgxy/resources/images/nav_bg.png" class="nav_bg_img"/>
        <ul class="nav_ul clearfix">
            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/index">
                    <span class="nav_name">首页</span>
                    <span class="nav_tips">Index</span>
                    <span class="line"></span>
                </a>
            </li>
            <li class="nav_ul_li">
            	<!-- 学院概况直接跳转详情,写死了文章的id -->
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=6181818762216150313">
                    <span class="nav_name">学院概况</span>
                    <span class="nav_tips">College</span>
                    <span class="line"></span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="http://218.7.10.11:88/zs/index_zs.php" target="_blank">
                    <span class="nav_name">招生网</span>
                    <span class="nav_tips">Supply</span>
                    <span class="line"></span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/jiuyewang">
                    <span class="nav_name">就业网</span>
                    <span class="nav_tips">Jobs</span>
                    <span class="line"></span>
                </a>
            </li>


            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=3946981313027664138">
                    <span class="nav_name hidden-xs">师德师风建设</span>
					<span class="nav_name visible-xs">师风建设</span>
                    <span class="nav_tips">Build</span>
                    <span class="line"></span>
                </a>
            </li>
<%--             <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=7868304688644257636&jgxySysMenuPId=1105405848443694891">
                    <span class="nav_name">信息公开</span>
                    <span class="nav_tips">Info</span>
                </a>
            </li> --%>
            <li class="nav_ul_li">
                <a href="${ctx}/xxgk/xxgkReception/index">
                    <span class="nav_name">信息公开</span>
                    <span class="nav_tips">Info</span>
                    <span class="line"></span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=5259940120822480279">
                    <span class="nav_name">继续教育</span>
                    <span class="nav_tips">Education</span>
                    <span class="line"></span>
                </a>
            </li>
            <li class="nav_ul_li">
                <a href="${ctx}/jgxy/jgxyReception/list?jgxySysMenuId=8292706150830458832">
                    <span class="nav_name">工作动态</span>
                    <span class="nav_tips">Dynamic</span>
                    <!-- <span class="line"></span> -->
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
    if(IEVersion() == -1){
        $('.nav_bg_img').remove();
    }
var cctx = "${ctx}";
function toList(){
	var title = $("#jnsc").val();
	//console.log(title);
	window.location.href=cctx+"/jgxy/jgxyReception/list?jgxyNoteTitle="+encodeURI(title);//encodeURIComponent(title)
}

</script>
