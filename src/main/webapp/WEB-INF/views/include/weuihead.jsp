<%@ page contentType="text/html;charset=UTF-8" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

<link rel="stylesheet" href="${ctxStatic}/weui/src/lib/weui.css" type="text/css">
<link rel="stylesheet" href="http://cdn.bootcss.com/weui/0.4.3/style/weui.min.css" type="text/css">
<link rel="stylesheet" href="http://cdn.bootcss.com/jquery-weui/0.8.0/css/jquery-weui.min.css" type="text/css">

<link rel="stylesheet" href="${ctxStatic}/weui/demos/css/demos.css">
<script src="${ctxStatic}/weui/src/lib/jquery-2.1.4.js"></script>
<script src="${ctxStatic}/weui/src/lib/fastclick.js"></script>
<script>
    $(function() {
        FastClick.attach(document.body);
    });
</script>

<script src="http://cdn.bootcss.com/jquery-weui/0.8.0/js/jquery-weui.min.js"></script>
<style type="text/css">
		.table>thead>tr>th{
			 border-collapse: collapse;
			border: 1px solid #D9D9D9;
			font-weight: 400;
			font-size: 12px;
		}
		.table>tbody>tr>td{
			 border-collapse: collapse;
			border: 1px solid #D9D9D9;
			font-weight: 400;
			font-size: 12px;
		}
		.page-content{
			padding-bottom: 50px;
		}
		.weui-tab{
			height: auto !important;
			position: relative;
			padding-bottom: 50px;
		}
    	.weui-tabbar{
    		position:fixed;
    		bottom: 0;
    		clear:both;
    	}
		.weui-bar__item--on{
			border-bottom: 2px solid #4C84C4;
			color: #333 !important;
		}
		.weui-navbar__item{
			color: #999;
		}
		.weui-media-box__title{
			font-size: 14px;
		}
		.demos-title{
			font-size: 20px !important;
		}
		.weui-body-box_desc {
		    color: #999999;
		    font-size: 13px;
		    line-height: 1.2;
		}
		body{
			font-family: -apple-system-font,Helvetica Neue,Helvetica,sans-serif;
  			background-color: #f8f8f8;
		}
		.weui-grid {
		    background: #fff !important;
		}
		.title_label_success{
			font-size: 8px;
			border: 1px solid #1AAD19;
			padding: 2px;
			border-radius: 2px;
		}
		.title_label_primary{
			font-size: 8px;
			border: 1px solid #4C84C4;
			padding: 2px;
			border-radius: 2px;
		}
		.margin-top0{
			margin-top:0px !important;
		}
</style>

      
