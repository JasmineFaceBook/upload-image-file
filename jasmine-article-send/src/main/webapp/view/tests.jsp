<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${ctx}/static/css/site.css" rel="stylesheet">
<script type="text/javascript" src="${ctx}/static/js/jquery.min.js"></script>
<script type="text/javascript" src="${ctx}/static/js/ajaxfileupload.js"></script>
<title>test wx</title>
</head>
<body>
<h3>请选择图片文件：JPG/GIF</h3> 
<form name="form0" id="form0" action="" method="post" enctype="multipart/form-data"> 
<input type="hidden" id="isUpdate" name="isUpdate" value="1"/>
<table>
<tr><td>姓名：</td><td><input type="text" id="personName" value="1" name="personName"/></td></tr>
<tr><td>学校：</td><td>
<select id="city" name="city" onchange="getCounty();">
</select>
<select id="county" name="county" onchange="getSchool();">
</select>
<select id="school" name="school" onchange="isOther();">
</select>
<input type="text" id="wschool" name="wshool" value="${school}"/>
</td></tr>
<tr><td>中队（班级）：</td><td><input type="text" id="personClass" value="" name="personClass"/></td></tr>
<tr><td>手机号：</td><td><input type="text" id="phone" value="" name="phone"/></td></tr>
<tr><td>作品类别：</td><td>
<select id="articleType" name="articleType">
<option value="1">小心愿</option>
<option value="2">小提案</option>
<option value="3">写给未来的自己</option>
</select>
</td></tr>
</table>
<!-- 这里特别说一下这个 multiple="multiple" 添加上这个之后可以一次选择多个文件进行上传，是 html5 的新属性-->  
<input type="file" name="wjs" id="wjs" multiple="multiple" /><br><img src="" id="img0" >
<input type="submit" value="提交" id="upload" onclick="submitForm();"/>
</form>  
<script>    
$(function(){
	$("#wschool").hide();
	$.ajax({
		type : "post",
		url : "${ctx}/img/get/city",
		data :{},
		dataType:"json",
		success : function(data) {
		var html="";
		html+="<option value=''>===请选择===</option>"
		for(var i=0;i<data.length;i++){
			html+="<option value='"+data[i].cityId+"'>"+data[i].cityName+"</option>"
		}
		$("#city").append(html);
		}
});
	
	 $("#upload").click(function () {
	   submitForm();
    });
});
function getCounty(){	
  var c=$("#city").val();
  $("#county").empty();
	$.ajax({
		type : "post",
		url : "${ctx}/img/get/county",
		data :{
			cityId:c
		},
		dataType:"json",
		success : function(data) {
		var html="";
		html+="<option value=''>===请选择===</option>"
		for(var i=0;i<data.length;i++){
			html+="<option value='"+data[i].countyId+"'>"+data[i].countyName+"</option>"
		}
		$("#county").append(html);
		}
	});
}
function getSchool(){
	var c=$("#county").val();
	$("#school").empty();
	$.ajax({
		type : "post",
		url : "${ctx}/img/get/school",
		data :{
			countyId:c
		},
		dataType:"json",
		success : function(data) {
		var html="";
		html+="<option value=''>===请选择===</option>"
		for(var i=0;i<data.length;i++){
			html+="<option value='"+data[i].schoolId+"'>"+data[i].schoolName+"</option>"
		}
		html+="<option value='other'>其他</option>"
		$("#school").append(html);
		}
	});
}
function isOther(){
	var s=$("#school").val();
	if(s=="other"){
		$("#wschool").show();
	}
	else{
		$("#wschool").hide();
	}
	
}
function submitForm(){
	var pname=$("#personName").val();
	var c=$("#city").val();
	var co=$("#county").val();
	var s=$("#school").val();
	if(s=='other'){
		s=$("#wschool").val();
	}
	var pc=$("#personClass").val();
	var ph=$("#phone").val();
	var isup=$("#isUpdate").val();
	/* if(pname==null||pname==''){
		alert("姓名不能为空");
		return false;
	}
	if(c==null||c==''){
		alert("城市不能为空!");
		return false;
	}
	if(co==null||co==''){
		alert("县不能为空!");
		return false;
	}
	if(s==null||s==''){
		alert("学校不能为空!");
		return false;
	}
	if(pc==null||pc==''){
		alert("班级不能为空!");
		return false;
	}
	if(ph==null||ph==''){
		alert("电话不能为空!");
		return false;
	}
	if(isup==null||isup==''){
		alert("是否更新不能为空!");
		return false;
	}
	 */
	/* var img=$("#img0").getAttr("src"); */
	var t=$("#articleType").val();
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
			personClass:pc,
			phone:ph,
			articleType:t,
			isUpdate:isup
		},
		dataType:"json",
		success : function(data) {
			alert("123");
			if(data.flag=='1'){
				$("#personName").val(data.opersonName);
				$("#city").empty();
				$("#city").val(data.ocity);
				$("#county").empty();
				$("#county").val(data.ocounty);
				$("#school").empty();
				$("#school").val(data.oschool);
				if(data.oschool=='other'){
					$("#wschool").show();
					$("#wschool").val(data.oschool);
				}
				$("#personClass").val(data.opersonClass);
				$("#phone").val(data.ophone);
				$("#isUpdate").val(data.isUpdate);
				var type="";
				if(data.oarticleType=='1'){
					type='1';
				}if(data.oarticleType=='2'){
					type='2';
				}if(data.oarticleType=='3'){
					type='3';
				}
				$("#articleType option[value='"+type+"']").attr("selected",true);
				$("#img0").attr("src","");
				alert("isup:"+$("#isUpdate").val());
				alert(''+data.message);
			}
			if(data.flag=='2'){
				$("#isUpdate").val(data.isUpdate);
				alert(''+data.message);
			}
			if(data.flag=='3'){
				alert(''+data.message);
			}
			if(data.flag=='4'){
				alert(''+data.message);
			}
			
			
		},
		 error : function(data) {
			 alert('系统异常！请与系统管理员联系!');
	   }
});
}

$("#wjs").change(function(){  
  var objUrl = getObjectURL(this.files[0]) ;   
  if (objUrl) {
    $("#img0").attr("src", objUrl) ;  
  }  
}) ;  
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


</body>
</html>