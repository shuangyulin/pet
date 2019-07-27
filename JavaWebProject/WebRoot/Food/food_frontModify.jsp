<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Food" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    Food food = (Food)request.getAttribute("food");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改宠物粮食信息</TITLE>
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
  		<li class="active">宠物粮食信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="foodEditForm" id="foodEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="food_foodId_edit" class="col-md-3 text-right">宠粮id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="food_foodId_edit" name="food.foodId" class="form-control" placeholder="请输入宠粮id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="food_foodName_edit" class="col-md-3 text-right">宠粮名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="food_foodName_edit" name="food.foodName" class="form-control" placeholder="请输入宠粮名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_foodPhoto_edit" class="col-md-3 text-right">宠粮照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="food_foodPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="food_foodPhoto" name="food.foodPhoto"/>
			    <input id="foodPhotoFile" name="foodPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_foodDesc_edit" class="col-md-3 text-right">宠粮介绍:</label>
		  	 <div class="col-md-9">
			    <script name="food.foodDesc" id="food_foodDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_foodNum_edit" class="col-md-3 text-right">库存数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="food_foodNum_edit" name="food.foodNum" class="form-control" placeholder="请输入库存数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="food_addDate_edit" class="col-md-3 text-right">上架日期:</label>
		  	 <div class="col-md-9">
                <div class="input-group date food_addDate_edit col-md-12" data-link-field="food_addDate_edit" data-link-format="yyyy-mm-dd">
                    <input class="form-control" id="food_addDate_edit" name="food.addDate" size="16" type="text" value="" placeholder="请选择上架日期" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxFoodModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#foodEditForm .form-group {margin-bottom:5px;}  </style>
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
var food_foodDesc_editor = UE.getEditor('food_foodDesc_edit'); //宠粮介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改宠物粮食界面并初始化数据*/
function foodEdit(foodId) {
  food_foodDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(foodId);
  });
}
 function ajaxModifyQuery(foodId) {
	$.ajax({
		url :  basePath + "Food/" + foodId + "/update",
		type : "get",
		dataType: "json",
		success : function (food, response, status) {
			if (food) {
				$("#food_foodId_edit").val(food.foodId);
				$("#food_foodName_edit").val(food.foodName);
				$("#food_foodPhoto").val(food.foodPhoto);
				$("#food_foodPhotoImg").attr("src", basePath +　food.foodPhoto);
				food_foodDesc_editor.setContent(food.foodDesc, false);
				$("#food_foodNum_edit").val(food.foodNum);
				$("#food_addDate_edit").val(food.addDate);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交宠物粮食信息表单给服务器端修改*/
function ajaxFoodModify() {
	$.ajax({
		url :  basePath + "Food/" + $("#food_foodId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#foodEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#foodQueryForm").submit();
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
    /*上架日期组件*/
    $('.food_addDate_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd',
    	minView: 2,
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
    foodEdit("<%=request.getParameter("foodId")%>");
 })
 </script> 
</body>
</html>

