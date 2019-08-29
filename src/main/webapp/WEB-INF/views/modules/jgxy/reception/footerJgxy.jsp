<%@ page contentType="text/html; charset=utf-8"%>   
<div class="footer_wrapper">

    <div id="jgxyFooterContents" style="border-bottom: 1px dashed #2282b5;margin-bottom: 6px;padding-bottom: 6px;">
    </div>
    <div class="text-center footer_link">
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
		$("#jgxyFooterContents").append(data.contents);
	},
	error:function(){
		//alert("出错");
	}
});
</script>