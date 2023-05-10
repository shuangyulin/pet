<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Pet" %>
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
<title>领养添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>Adopt/frontlist">领养列表</a></li>
			    	<li role="presentation" class="active"><a href="#adoptAdd" aria-controls="adoptAdd" role="tab" data-toggle="tab">添加领养</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="adoptList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="adoptAdd"> 
				      	<form class="form-horizontal" name="adoptAddForm" id="adoptAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="adopt_petObj_petId" class="col-md-2 text-right">被领养宠物:</label>
						  	 <div class="col-md-8">
							    <select id="adopt_petObj_petId" name="adopt.petObj.petId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="adopt_userObj_user_name" class="col-md-2 text-right">领养人:</label>
						  	 <div class="col-md-8">
							    <select id="adopt_userObj_user_name" name="adopt.userObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="adopt_addTimeDiv" class="col-md-2 text-right">领养申请时间:</label>
						  	 <div class="col-md-8">
				                <div id="adopt_addTimeDiv" class="input-group date adopt_addTime col-md-12" data-link-field="adopt_addTime">
				                    <input class="form-control" id="adopt_addTime" name="adopt.addTime" size="16" type="text" value="" placeholder="请选择领养申请时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="adopt_shenHe" class="col-md-2 text-right">审核状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="adopt_shenHe" name="adopt.shenHe" class="form-control" placeholder="请输入审核状态">
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxAdoptAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#adoptAddForm .form-group {margin:10px;}  </style>
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
	//提交添加领养信息
	function ajaxAdoptAdd() { 
		//提交之前先验证表单
		$("#adoptAddForm").data('bootstrapValidator').validate();
		if(!$("#adoptAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Adopt/add",
			dataType : "json" , 
			data: new FormData($("#adoptAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#adoptAddForm").find("input").val("");
					$("#adoptAddForm").find("textarea").val("");
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
	//验证领养添加表单字段
	$('#adoptAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"adopt.addTime": {
				validators: {
					notEmpty: {
						message: "领养申请时间不能为空",
					}
				}
			},
			"adopt.shenHe": {
				validators: {
					notEmpty: {
						message: "审核状态不能为空",
					}
				}
			},
		}
	}); 
	//初始化被领养宠物下拉框值 
	$.ajax({
		url: basePath + "Pet/listAll",
		type: "get",
		success: function(pets,response,status) { 
			$("#adopt_petObj_petId").empty();
			var html="";
    		$(pets).each(function(i,pet){
    			html += "<option value='" + pet.petId + "'>" + pet.petName + "</option>";
    		});
    		$("#adopt_petObj_petId").html(html);
    	}
	});
	//初始化领养人下拉框值 
	$.ajax({
		url: basePath + "UserInfo/listAll",
		type: "get",
		success: function(userInfos,response,status) { 
			$("#adopt_userObj_user_name").empty();
			var html="";
    		$(userInfos).each(function(i,userInfo){
    			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
    		});
    		$("#adopt_userObj_user_name").html(html);
    	}
	});
	//领养申请时间组件
	$('#adopt_addTimeDiv').datetimepicker({
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
		$('#adoptAddForm').data('bootstrapValidator').updateStatus('adopt.addTime', 'NOT_VALIDATED',null).validateField('adopt.addTime');
	});
})
</script>
</body>
</html>
