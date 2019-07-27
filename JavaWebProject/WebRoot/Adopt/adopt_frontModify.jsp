<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Adopt" %>
<%@ page import="com.chengxusheji.po.Pet" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的petObj信息
    List<Pet> petList = (List<Pet>)request.getAttribute("petList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    Adopt adopt = (Adopt)request.getAttribute("adopt");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改领养信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">领养信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="adoptEditForm" id="adoptEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="adopt_adoptId_edit" class="col-md-3 text-right">领养id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="adopt_adoptId_edit" name="adopt.adoptId" class="form-control" placeholder="请输入领养id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="adopt_petObj_petId_edit" class="col-md-3 text-right">被领养宠物:</label>
		  	 <div class="col-md-9">
			    <select id="adopt_petObj_petId_edit" name="adopt.petObj.petId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="adopt_userObj_user_name_edit" class="col-md-3 text-right">领养人:</label>
		  	 <div class="col-md-9">
			    <select id="adopt_userObj_user_name_edit" name="adopt.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="adopt_addTime_edit" class="col-md-3 text-right">领养申请时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date adopt_addTime_edit col-md-12" data-link-field="adopt_addTime_edit">
                    <input class="form-control" id="adopt_addTime_edit" name="adopt.addTime" size="16" type="text" value="" placeholder="请选择领养申请时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="adopt_shenHe_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="adopt_shenHe_edit" name="adopt.shenHe" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxAdoptModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#adoptEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改领养界面并初始化数据*/
function adoptEdit(adoptId) {
	$.ajax({
		url :  basePath + "Adopt/" + adoptId + "/update",
		type : "get",
		dataType: "json",
		success : function (adopt, response, status) {
			if (adopt) {
				$("#adopt_adoptId_edit").val(adopt.adoptId);
				$.ajax({
					url: basePath + "Pet/listAll",
					type: "get",
					success: function(pets,response,status) { 
						$("#adopt_petObj_petId_edit").empty();
						var html="";
		        		$(pets).each(function(i,pet){
		        			html += "<option value='" + pet.petId + "'>" + pet.petName + "</option>";
		        		});
		        		$("#adopt_petObj_petId_edit").html(html);
		        		$("#adopt_petObj_petId_edit").val(adopt.petObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#adopt_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#adopt_userObj_user_name_edit").html(html);
		        		$("#adopt_userObj_user_name_edit").val(adopt.userObjPri);
					}
				});
				$("#adopt_addTime_edit").val(adopt.addTime);
				$("#adopt_shenHe_edit").val(adopt.shenHe);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交领养信息表单给服务器端修改*/
function ajaxAdoptModify() {
	$.ajax({
		url :  basePath + "Adopt/" + $("#adopt_adoptId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#adoptEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#adoptQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    /*领养申请时间组件*/
    $('.adopt_addTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    adoptEdit("<%=request.getParameter("adoptId")%>");
 })
 </script> 
</body>
</html>

