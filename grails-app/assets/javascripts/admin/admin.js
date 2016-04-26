//= require_self

if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}


/***
* 提示表单错误信息
*/
function showFormErrors(obj,msg){
	
	$(obj).parent().addClass("has-error");
	abox("error",msg);
}

/**
* 清除所有表单的错误信息
*/
function cleanFormErrors(){
	
	$("div.has-error").removeClass("has-error");
}	


function checkNumber(value){    
	var reg = /^((\d+)|(-\d+))$/;    
	if(!reg.test($.trim(value))){    
		return false;    
	}    
	return true;    
}


function checkPrice(value){
	var reg = /^((\d+)|(\d+.\d+))$/;
	if(!reg.test($.trim(value))){    
		return false;    
	}    
	return true;
}

/**
*
* 控制提交按钮是否可用
*/
function openSubBtn(bool){
    if(bool){
        $(".subBtn").each(function (){
           $(this).attr("disabled",false);
           $(this).removeClass("disabled");
           $(this).button('reset');
        });
    }else{
        $(".subBtn").each(function (){
            $(this).attr("disabled","disabled");
            $(this).addClass("disabled");
        });
    }
}

/**
* 跳转到上一级页面
*/
function goBack(){

    var refererUrl = $("#refererUrl").val();
    location.href=refererUrl;
}



/* 系统弹出提示框
 * @author maqiankun
 * 参数 operate 提示类型 : sucess 成功 ，error 失败
 * 	       msg 提示内容 : 不写为默认值    
 * callback 回调函数
 */
function abox(operate,msg,callback){
	 $('#abox').remove();
	 var sucess = "操作成功 ！",error = "操作失败 ！";
	 var C=null,$win = $(window);
	 var _html = "<div id = 'abox' class=''><h4></h4><button type='button' class='aboxclose' onClick='closes()'>×</button></div>";
	 //var _html = "<div id = 'abox' class='alert-float alert-error'><h4></h4><button type='button' class='close' onClick='closes()'>×</button></div>";
	 C = $(_html).appendTo("body");
	 if (!C) {
	     return false;
	  }
	 //改变css样式
	 C.attr('class','abox-float abox-'+operate);
	 if(operate=='success'){
	  C.children("h4").html(msg==''||msg==null?sucess:msg);
	 }else if(operate=='error'){
	  C.children("h4").html(msg==''||msg==null?error:msg);
	 }
	 
	 //设置提示框的位置
	 var w = C.width();
	 var l = ($win.width() - w) / 2;
	 var t = $win.scrollTop() + $win.height() /10;
	 C.css({
	       left: l,
	       top: 46
	 });
     setTimeout(function (){
        var h = $('#abox');
	        if (h) {
	            h.stop().fadeOut(1000, function(){
	                h.remove();
	                if(callback) {
	                 callback();
	                }
	            })
	        }
	    }, 1000);//2秒自动关闭
}

