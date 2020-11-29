<%@ page contentType="text/html; charset=utf-8"%>   
<div class="footer_wrapper">

    <div class="row" style="border-bottom: 1px dashed #2282b5;margin-bottom: 6px;padding-bottom: 6px;position: relative;">
	    <div id="jgxyFooterContents"  class="col-sm-12" >
	    </div>
	    <!--<div class="col-sm-1" style="padding-left: 10px">-->
	    	<!--<script type="text/javascript">document.write(unescape("%3Cspan id='_ideConac' %3E%3C/span%3E%3Cscript   src='http://dcs.conac.cn/js/10/000/0000/60445220/CA100000000604452200003.js' type='text/javascript'%3E%3C/script%3E"));</script>-->
	    	<span id="_ideConac" style="position: absolute;right:0;top:0;">
				<a href="//bszs.conac.cn/sitename?method=show&amp;id=08CD3166ED675397E053022819AC5D79" target="_blank">
					<img id="imgConac" vspace="0" hspace="0" border="0" src="${pageContext.request.contextPath}/jgxy/resources/images/shiyedanwei.png" >
				</a>
			</span>
	    <!-- </div> -->
    </div>
    <div class="text-center">
        <a href="http://www.hljsf.gov.cn/" target="_blank"  class="friendship_link">黑龙江省司法厅</a>
        <a href="https://gaokao.chsi.com.cn/" target="_blank"  class="friendship_link">教育部阳光高考信息平台</a>
        <a href="http://www.hljzfxy.org.cn/" target="_blank"  class="friendship_link">黑龙江政法管理干部学院</a>
        <a href="https://www.lzk.hl.cn/" target="_blank"  class="friendship_link">黑龙江招生考试信息港</a>
    </div>
</div>
<script type="text/javascript">
var cctx = "${ctx}";
$.ajax({
	url:"${ctx}/jgxy/jgxyReception/getFooterJgxy",
	type:"POST",
	async:true,    //或false,是否异步
	dataType:'json',
	success:function(data){
		console.log(data);
		$("#jgxyFooterContents").append(data.contents);
	},
	error:function(){
		//alert("出错");
	}
});
</script>