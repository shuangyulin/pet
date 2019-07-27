<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.FoodOrder" %>
<%@ page import="com.chengxusheji.po.Food" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的foodObj信息
    List<Food> foodList = (List<Food>)request.getAttribute("foodList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    FoodOrder foodOrder = (FoodOrder)request.getAttribute("foodOrder");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改宠粮订单信息</TITLE>
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
  		<li class="active">宠粮订单信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="foodOrderEditForm" id="foodOrderEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="foodOrder_orderId_edit" class="col-md-3 text-right">订单id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="foodOrder_orderId_edit" name="foodOrder.orderId" class="form-control" placeholder="请输入订单id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="foodOrder_foodObj_foodId_edit" class="col-md-3 text-right">宠粮名称:</label>
		  	 <div class="col-md-9">
			    <select id="foodOrder_foodObj_foodId_edit" name="foodOrder.foodObj.foodId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="foodOrder_userObj_user_name_edit" class="col-md-3 text-right">预订用户:</label>
		  	 <div class="col-md-9">
			    <select id="foodOrder_userObj_user_name_edit" name="foodOrder.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="foodOrder_orderNumber_edit" class="col-md-3 text-right">预订数量:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="foodOrder_orderNumber_edit" name="foodOrder.orderNumber" class="form-control" placeholder="请输入预订数量">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="foodOrder_orderState_edit" class="col-md-3 text-right">订单状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="foodOrder_orderState_edit" name="foodOrder.orderState" class="form-control" placeholder="请输入订单状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="foodOrder_orderTime_edit" class="col-md-3 text-right">预订时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date foodOrder_orderTime_edit col-md-12" data-link-field="foodOrder_orderTime_edit">
                    <input class="form-control" id="foodOrder_orderTime_edit" name="foodOrder.orderTime" size="16" type="text" value="" placeholder="请选择预订时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxFoodOrderModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#foodOrderEditForm .form-group {margin-bottom:5px;}  </style>
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
/*弹出修改宠粮订单界面并初始化数据*/
function foodOrderEdit(orderId) {
	$.ajax({
		url :  basePath + "FoodOrder/" + orderId + "/update",
		type : "get",
		dataType: "json",
		success : function (foodOrder, response, status) {
			if (foodOrder) {
				$("#foodOrder_orderId_edit").val(foodOrder.orderId);
				$.ajax({
					url: basePath + "Food/listAll",
					type: "get",
					success: function(foods,response,status) { 
						$("#foodOrder_foodObj_foodId_edit").empty();
						var html="";
		        		$(foods).each(function(i,food){
		        			html += "<option value='" + food.foodId + "'>" + food.foodName + "</option>";
		        		});
		        		$("#foodOrder_foodObj_foodId_edit").html(html);
		        		$("#foodOrder_foodObj_foodId_edit").val(foodOrder.foodObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#foodOrder_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#foodOrder_userObj_user_name_edit").html(html);
		        		$("#foodOrder_userObj_user_name_edit").val(foodOrder.userObjPri);
					}
				});
				$("#foodOrder_orderNumber_edit").val(foodOrder.orderNumber);
				$("#foodOrder_orderState_edit").val(foodOrder.orderState);
				$("#foodOrder_orderTime_edit").val(foodOrder.orderTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交宠粮订单信息表单给服务器端修改*/
function ajaxFoodOrderModify() {
	$.ajax({
		url :  basePath + "FoodOrder/" + $("#foodOrder_orderId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#foodOrderEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#foodOrderQueryForm").submit();
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
    /*预订时间组件*/
    $('.foodOrder_orderTime_edit').datetimepicker({
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
    foodOrderEdit("<%=request.getParameter("orderId")%>");
 })
 </script> 
</body>
</html>

