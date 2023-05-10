<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Food" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>宠粮订单添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>FoodOrder/frontlist">宠粮订单列表</a></li>
			    	<li role="presentation" class="active"><a href="#foodOrderAdd" aria-controls="foodOrderAdd" role="tab" data-toggle="tab">添加宠粮订单</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="foodOrderList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="foodOrderAdd"> 
				      	<form class="form-horizontal" name="foodOrderAddForm" id="foodOrderAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="foodOrder_foodObj_foodId" class="col-md-2 text-right">宠粮名称:</label>
						  	 <div class="col-md-8">
							    <select id="foodOrder_foodObj_foodId" name="foodOrder.foodObj.foodId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="foodOrder_userObj_user_name" class="col-md-2 text-right">预订用户:</label>
						  	 <div class="col-md-8">
							    <select id="foodOrder_userObj_user_name" name="foodOrder.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="foodOrder_orderNumber" class="col-md-2 text-right">预订数量:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="foodOrder_orderNumber" name="foodOrder.orderNumber" class="form-control" placeholder="请输入预订数量">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="foodOrder_orderState" class="col-md-2 text-right">订单状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="foodOrder_orderState" name="foodOrder.orderState" class="form-control" placeholder="请输入订单状态">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="foodOrder_orderTimeDiv" class="col-md-2 text-right">预订时间:</label>
						  	 <div class="col-md-8">
				                <div id="foodOrder_orderTimeDiv" class="input-group date foodOrder_orderTime col-md-12" data-link-field="foodOrder_orderTime">
				                    <input class="form-control" id="foodOrder_orderTime" name="foodOrder.orderTime" size="16" type="text" value="" placeholder="请选择预订时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxFoodOrderAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#foodOrderAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var basePath = "<%=basePath%>";
	//提交添加宠粮订单信息
	function ajaxFoodOrderAdd() { 
		//提交之前先验证表单
		$("#foodOrderAddForm").data('bootstrapValidator').validate();
		if(!$("#foodOrderAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "FoodOrder/add",
			dataType : "json" , 
			data: new FormData($("#foodOrderAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#foodOrderAddForm").find("input").val("");
					$("#foodOrderAddForm").find("textarea").val("");
				} else {
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
	//验证宠粮订单添加表单字段
	$('#foodOrderAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"foodOrder.orderNumber": {
				validators: {
					notEmpty: {
						message: "预订数量不能为空",
					},
					integer: {
						message: "预订数量不正确"
					}
				}
			},
			"foodOrder.orderState": {
				validators: {
					notEmpty: {
						message: "订单状态不能为空",
					}
				}
			},
			"foodOrder.orderTime": {
				validators: {
					notEmpty: {
						message: "预订时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化宠粮名称下拉框值 
	$.ajax({
		url: basePath + "Food/listAll",
		type: "get",
		success: function(foods,response,status) { 
			$("#foodOrder_foodObj_foodId").empty();
			var html="";
    		$(foods).each(function(i,food){
    			html += "<option value='" + food.foodId + "'>" + food.foodName + "</option>";
    		});
    		$("#foodOrder_foodObj_foodId").html(html);
    	}
	});
	//初始化预订用户下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#foodOrder_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#foodOrder_userObj_user_name").html(html);
    	}
	});
	//预订时间组件
	$('#foodOrder_orderTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#foodOrderAddForm').data('bootstrapValidator').updateStatus('foodOrder.orderTime', 'NOT_VALIDATED',null).validateField('foodOrder.orderTime');
	});
})
</script>
</body>
</html>
