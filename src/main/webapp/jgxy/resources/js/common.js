// 请求头部字符串 公共部分
function header_str(){
    $.ajax({
        url : "headerJgxy.html",
        type : "GET",
        data : {},
        success : function(data){
            $('.header').html(data);
        },
    });
}

// 请求底部字符串 公共部分
function footer_str(){
    $.ajax({
        url : "footerJgxy.html",
        type : "GET",
        data : {},
        success : function(data){
            $('.footer').html(data);
        },
    });
}


