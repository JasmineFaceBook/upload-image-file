<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>好少年微信投稿</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no" name="viewport">
    <meta content="yes" name="apple-mobile-web-app-capable">
    <meta content="black" name="apple-mobile-web-app-status-bar-style">
    <meta content="telephone=no" name="format-detection">
    <meta name="renderer" content="webkit">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <link rel="stylesheet" href="${ctx}/static/css/jquery.mobile-1.4.5.min.css">
    <link rel="stylesheet" href="${ctx}/static/css/home.css">
    <script src="${ctx}/static/js/jquery.min.js"></script>
    <script src="${ctx}/static/js/jquery.mobile-1.4.5.js"></script>
    <script src="${ctx}/static/js/touch.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/ajaxfileupload.js"></script>
</head>
<style>
 .showFileName1{
        position: absolute;
        left:0;
        top:0;
        right:0;
    }
</style>
<script>
    (function (doc, win) {
        var docEl = doc.documentElement,
            resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
            recalc = function () {
                var clientWidth = docEl.clientWidth;
                if (!clientWidth) return;
                if (clientWidth >= 640) {
                    docEl.style.fontSize = '100px';
                } else {
                    docEl.style.fontSize = 100 * (clientWidth / 640) + 'px';
                }
            };

        if (!doc.addEventListener) return;
        win.addEventListener(resizeEvt, recalc, false);
        doc.addEventListener('DOMContentLoaded', recalc, false);
    })(document, window); 
    
   
</script>
<body>
<div class="oWrap" id="oWrapBg"></div>
<div class="loading">
    <img src="${ctx}/static/img/loading.gif" alt="">
</div>
<div class="container " data-role="none" >
    <div class="header">
        <h2>请填写你的报名信息</h2>
   </div>
    <div class="form-box">
        <form method="post" action="">
            <div class="ui-field-contain">
               <div class="input-box">
               <input type="hidden" id="isUpdate" name="isUpdate" value="1"/>
                   <label for="fullname" class="m-b1">*姓名</label>
                   <input type="text" name="personName" bool='autofucs' id="personName" value="${opersonName}">
               </div>
                <div class="input-box">
                    <label for="" class="m-b1">*学校</label>
                     <div  class=" ui-select-scholl">
                         <select id="city" name="city" onchange="getCounty();">
                         <option value="">请选择</option>
							<c:forEach items="${citylist}" var="name">
							<option value="${name.cityId }"
							<c:if test="${name.cityId==ocity}">selected</c:if>							
							>${name.cityName }</option>
							</c:forEach>
                       </select>
                     </div>
                  <div class="ui-select-second">
                      <select id="county" name="county" onchange="getSchool();">
                       <option value="">请选择</option>
							<c:forEach items="${countylist}" var="name">
							<option value="${name.countyId }"
							<c:if test="${name.countyId==ocounty}">selected</c:if>							
							>${name.countyId }</option>
							</c:forEach>
                      </select>
                  </div>
                    <div class="ui-select-third">
                    <select id="school" name="school" onchange="isOther();">
                    <option value="">===请选择===</option>
							<c:forEach items="${schoollist}" var="name">
							<option value="${name.schoolId }"
							<c:if test="${name.schoolId==oschool}">selected</c:if>							
							>${name.schoolId }</option>
							</c:forEach>
                    </select>
                    </div>
                    <div id="is_wschool">
                    <input type="text" id="wschool" name="wschool" value="${owschool}"/>
                    </div>
                </div>
                <div class="input-box class-box">
                <label for="">*中队(班级)</label>
                <input type="text" name="personClass" bool='autofucs' id="personClass" value="${opersonClass}">
                 </div>
                <div class="input-box mt-10">
                <label for="fullname" class="m-b1">*手机</label>
                <input type="text" name="phone" bool='autofucs' id="phone" value="${ophone}">
                </div>
                <div class="input-box">
                    <label for="fullname" class="m-b1">*作品</label>
                    <div class="file file-box">
                        <span>上传图片</span>
                        <div id="enterFile">
                        <input type="file"  name="wjs" id="wjs" multiple="multiple" value="上传图片"/>
                       </div>
                    </div>

                        <div class="ui-select-fisrt left-box">
                        <select name="articleType" id="articleType">
                            <option value="1" <c:if test="${oarticleType=='1'}">selected</c:if>
                            >小心愿</option>
                            <option value="2"<c:if test="${oarticleType=='2'}">selected</c:if>
                            >小提案</option>
                            <option value="3"<c:if test="${oarticleType=='3'}">selected</c:if>
                            >写给未来的自己</option>
                        </select>
                        </div>

                </div>
                <div class="input-box zuopin-box">
                    <%-- <img src="${ctx}/static/img/img.png" alt=""> --%>
                    <img src="" id="img0" >
                </div>
            </div>
            <div class="btn-box" data-role="none" id="upload">
                <span  id="btn-sub"  value="">提交</span>
            </div>
        </form>
    </div>
</div>
<div class="sucuess-msg">
    <span></span>
    <div class="msg-box">
        <button class="btn btn-bg01">返回</button>
        <button class="btn btn-bg02">退出</button>

    </div>
</div>
</body>

<script>
$(function () {
	/* DiskFileUpload fu = new DiskFileUpload(); 
	// 设置最大文件尺寸，这里是10MB 
	fu.setSizeMax(10485760); 
	// 设置缓冲区大小，这里是4kb 
	fu.setSizeThreshold(10485760);  */
	
	var startx,starty;
    var stopToch = true;
    document.addEventListener("touchstart",function(e){
        startx = event.touches[0].pageX;
        starty = event.touches[0].pageY;


    },false);
    document.addEventListener("touchmove",function(e){

        moveEndX = e.touches[0].pageX;
            moveEndY =  e.touches[0].pageY
        X = moveEndX - startx,

                Y = moveEndY - starty;


            if   (Math.abs(X) > Math.abs(Y) && X > 0) {
                console.log('左边')
                e.preventDefault();
               e.stopPropagation();
            }

            else if (Math.abs(X) > Math.abs(Y) && X < 0) {
                console.log('右边')
                e.preventDefault();
                e.stopPropagation();

            }


    },false);

	 /* var stopToch=true;
	    document.addEventListener("touchmove",function(e){
	        if(stopToch){
	            e.preventDefault();
	            e.stopPropagation();
	        }
	    },false);  */
	    
	   

	    


	/* $("#is_wschool").hide(); */
	 $(".zuopin-box img").attr("src","${ctx}/static/img/aginSub.png")
	$("#city").empty();
	 $("#county").empty();
	  $("#school").empty();
	$.ajax({
		type : "post",
		url : "${ctx}/img/get/city",
		data :{},
		dataType:"json",
		success : function(data) {
		var html="";
		 html+="<option value=''>请选择</option>"
		for(var i=0;i<data.length;i++){
			html+="<option value='"+data[i].cityId+"'>"+data[i].cityName+"</option>"
		}
		$("#city").append(html);
		}
});
	
    $("input").attr('data-role','none');
    $("#btn-sub").click(function () {
    	
    	/*  var file=$("#wjs")[0].files[0];//得到文件对象  
         var totalsize=file.size;//文件 总的大小  
    	if(totalsize>2097152){
    		confirm("上传图片大小不能大于2MB!");
    	} */
    	var pname=$("#personName").val();
    	if(pname==null||pname==''){
    		confirm("姓名不能为空!");
    		return false;
    		}
    	var c=$("#city").val();
    	 if(c==null||c==''){
    			confirm("城市不能为空!");
    			return false;
    		}
    	var co=$("#county").val();
    	if(co==null||co==''){
    		confirm("县不能为空!");
    		return false;
    	}
    	var s=$("#school").val();
    	var ws=$("#wschool").val();
    	if((s==null||s==''||s=='other')&&(ws==null||ws=='')){
    		confirm("学校不能为空!");
    		return false;
    	}
    	var pc=$("#personClass").val();
    	if(pc==null||pc==''){
    		confirm("班级不能为空!");
    		return false;
    	}
    	var ph=$("#phone").val();
    	if(ph==null||ph==''){
    		confirm("电话不能为空!");
    		return false;
    	}
    	var pattern = /^1[34578]\d{9}$/;  
    	
    	if(!pattern.test(ph)){
    		confirm("手机号码格式不正确!");
    		return false;
    	}
    	var isup=$("#isUpdate").val();
    	 var fileurl = $("#img0")[0].src;
    	if(fileurl.indexOf('aginSub.png')> 0){
    		confirm("上传图片不能为空!");
    		return false;
    	} 
    	var fp = $("#wjs");
    	var items = fp[0].files;
    	var fileName=".jpg";
    	 if(items[0]!=null&&items[0]!=''&&items[0]!= undefined){
    		fileName=items[0].name;
    	}
    	/*  var sfileName=fileName.substr(fileName.lastIndexOf("/")+1).toLowerCase(); */
    	var lastName=fileName.substr(fileName.lastIndexOf(".")+1).toLowerCase();
    	
    	if(fileName==null||fileName==''){
    	confirm("上传图片不能为空!");
		return false;
	   } 
    	if(lastName=='bmp'||lastName=='jpg'||lastName=='jpeg'||lastName=='png'||lastName=='gif'){
    	}
    	else{
    		confirm("上传文件只能是图片!");
    		return false;
    	}
	 var t=$("#articleType").val();
	 
	 $(".oWrap").show();
	 $(".loading").show();
		$.ajaxFileUpload({		 
			 url : "${ctx}/img/upload",
			 fileElementId : 'wjs',
			 type : "post",
		     async: false,
			 data :{
				personName:pname,
				city:c,
			    county:co,		
				school:s,
				wschool:ws,
				personClass:pc,
				phone:ph,
				articleType:t,
				isUpdate:isup
			},
			dataType:"json",
			success : function(data) {
				/* alert("123"); */
				if(data.flag=='1'){
					$("#personName").val(data.opersonName);
					$("#personClass").val(data.opersonClass);
					$("#phone").val(data.ophone);
					$("#isUpdate").val(data.isUpdate);	
					  $(".zuopin-box img").attr("src","${ctx}/static/img/aginSub.png") 	 
					 if(data.owschool != undefined ){
						 $("#wschool").attr("type","text");
						 $("#wschool").val(data.owschool); 
					 }
					 
					if(confirm(""+data.message)){
						
					}else{
						WeixinJSBridge.call('closeWindow');
					}
					
					$("#btn-sub").text('确认修改作品')
				}
				if(data.flag=='2'){
					$("#isUpdate").val(data.isUpdate);
					$(".zuopin-box img").attr("src","${ctx}/static/img/aginSub.png")
					$("#btn-sub").text('再次提交作品')
                    if(confirm(""+data.message)){
						
					}else{
						WeixinJSBridge.call('closeWindow');
					}
				}
				if(data.flag=='3'){
					$(".zuopin-box img").attr("src","${ctx}/static/img/aginSub.png")
					$("#btn-sub").text('再次提交作品')
                    if(confirm(""+data.message)){
						
					}else{
						WeixinJSBridge.call('closeWindow');
					}
				}
				if(data.flag=='4'){
					var W=document.documentElement.clientWidth;//body
			        var H=document.documentElement.clientHeight;//body
			        var oDelBg=document.getElementById('oWrapBg');
			        document.documentElement.style.overflow='hidden';
			        oDelBg.style.width=W+'px';
			        oDelBg.style.height=H+'px';
			        $(".oWrap").show();
			        $(".sucuess-msg").addClass('animation')
			        $(".sucuess-msg").show();
				}
				else{
					$(".oWrap").hide();
				}
				if(data.flag=='5'){
					$(".zuopin-box img").attr("src","${ctx}/static/img/aginSub.png")
					$("#btn-sub").text('重新提交作品');
                    if(confirm(""+data.message)){
						
					}else{
						WeixinJSBridge.call('closeWindow');
					}	
				}
				if(data.flag=='6'){
					$(".zuopin-box img").attr("src","${ctx}/static/img/aginSub.png")
					$("#btn-sub").text('重新提交作品');
                    if(confirm(""+data.message)){
						
					}else{
						WeixinJSBridge.call('closeWindow');
					}	
				}
				$("#wjs").bind("change", function(){
			     	  var objUrl = getObjectURL(this.files[0]);
			     	  if (objUrl) {		     	  
			     	    $("#img0").attr("src", objUrl) ;  
			     	  }  
			   });
						
				/* $("#wjs").attr("style","visibility: hidden;"); */
				 /* $("#wjs").remove(); 
				 $("#enterFile").append("<input type='file'  name='wjs' id='wjs' multiple='multiple' value='上传图片'/>");
				 */
				/* 将file文件的值去掉
				$("#wjs").after($("#wjs").clone().val(""));      
				 $("#wjs").remove();  */ 
				 		
				$(".loading").hide();
			},
			 error : function(data) {
				 alert('系统异常！请与系统管理员联系!');
		   }
	});

    });

    $("#wjs").change(function(){ 
  	  
      var objUrl = getObjectURL(this.files[0]);
  	  if (objUrl) {
  	    $("#img0").attr("src", objUrl);  
  	  }  
  	});  
    
    $(".btn-bg01").click(function () {
        $(".sucuess-msg").fadeOut();
//        $(".sucuess-msg").addClass('back-animate').hide();

        $(".oWrap").hide();

        $(".zuopin-box img").attr("src","${ctx}/static/img/aginSub.png")
        $("#btn-sub").text('再次提交作品')

    });
    $(".btn-bg02").click(function () {
    	WeixinJSBridge.call('closeWindow');
    });
    
    //自动切换焦点
   /* $(document).keydown(function(event){ 
    if(event.keyCode==13){ 
    	
     } 
   }); */
   
   $("#personName").keydown(function(event){ 
      if(event.keyCode==13){    		
	    		$("#city").focus();
	   	
	    }
   });
   $("#city").keydown(function(event){ 
	      if(event.keyCode==13){ 
		    		$("#county").focus();		
		    	
		    }
	   });
   $("#county").keydown(function(event){ 
	      if(event.keyCode==13){ 
		    		
		    		$("#school").focus();
		    		
	    			
		    	
		    }
	   });
   $("#school").keydown(function(event){ 
	      if(event.keyCode==13){ 
		    		
		    	if($("#school").val()=='other')	{
		    		$("#wschool").focus();		
		    	}
		    	else{
		    		$("#personClass").focus();
		    	}    		
	    		
		    }
	   });
   $("#wschool").keydown(function(event){ 
	      if(event.keyCode==13){ 	    	
		    		$("#personClass").focus();
		    		
		    	
		    }
	   });
   $("#personClass").keydown(function(event){ 
	      if(event.keyCode==13){ 	    	
		    		$("#phone").focus();
	    		
		    	
		    }
	   });
   $("#phone").keydown(function(event){ 
	      if(event.keyCode==13){ 	    	
	    		$("#articleType").focus();
	    		
		    }
	   });
    
});

 function JumpToNext(){ 
	if(event.keyCode==13) 
	{ 
	var nextFocusIndex=this.getAttribute("nextFocusIndex"); 
	document.all[nextFocusIndex].focus(); 
	} 
	}  


function getCounty(){	
	  var c=$("#city").val();
	 /*  $("#is_wschool").hide(); */
	  $("#county-button span").empty();
	  $("#school-button span").empty();
	  $("#county").empty();
	  $("#school").empty();
		$.ajax({
			type : "post",
			url : "${ctx}/img/get/county",
			data :{
				cityId:c
			},
			dataType:"json",
			success : function(data) {
				if($("#city").val()==''){
					$("#county-button span").empty();
					  $("#school-button span").empty();
					  $("#county").empty();
					  $("#school").empty();
					  $("#is_wschool").hide();
				}
				else{
					
					var html="";
					html+="<option value=''>请选择</option>"
					if(null!=data[0].countyId&&data[0].countyId!=undefined){
						for(var i=0;i<data.length;i++){
							html+="<option value='"+data[i].countyId+"'>"+data[i].countyName+"</option>"
						}	
					}					
					$("#county").append(html);
				}
			
			}
		});
	}
	function getSchool(){
		var c=$("#county").val();
		/* $("#is_wschool").hide(); */
		$("#school-button span").empty();
		$("#school").empty();
		$.ajax({
			type : "post",
			url : "${ctx}/img/get/school",
			data :{
				countyId:c
			},
			dataType:"json",
			success : function(data) {
				if($("#county").val()==''){
					$("#is_wschool").hide();
					$("#school-button span").empty();
					$("#school").empty();
				}
				else{
					var html="";
					 html+="<option value=''>===请选择===</option>"
					if(null!=data[0].schoolId&&data[0].schoolId!=undefined){
					for(var i=0;i<data.length;i++){
						html+="<option value='"+data[i].schoolId+"'>"+data[i].schoolName+"</option>"
					}
					html+="<option value='other'>其他</option>";
					}
					$("#school").append(html);
					
				}
				}		
		});
	}
	 function isOther(){	
		var s=$("#school").val();
		if(s=="other"){
			/* $("#is_wschool").show(); */
			$("#wschool").show();
		}
		else{
			/* $("#is_wschool").hide(); */
			$("#wschool").hide();
		}
		
	} 
	//建立一個可存取到該file的url  
	function getObjectURL(file) {
	  var url = null ;   
	  // 下面函数执行的效果是一样的，只是需要针对不同的浏览器执行不同的 js 函数而已  
	  if (window.createObjectURL!=undefined) { // basic  
	    url = window.createObjectURL(file) ;  
	  } else if (window.URL!=undefined) { // mozilla(firefox)  
	    url = window.URL.createObjectURL(file) ;  
	  } else if (window.webkitURL!=undefined) { // webkit or chrome  
	    url = window.webkitURL.createObjectURL(file) ;  
	  }  
	  return url ;  
	}  
</script>
</html>