<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>宠物粮食添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-12 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Food/frontlist">宠物粮食管理</a></li>
  			<li class="active">添加宠物粮食</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="foodAddForm" id="foodAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="food_foodName" class="col-md-2 text-right">宠粮名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="food_foodName" name="food.foodName" class="form-control" placeholder="请输入宠粮名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="food_foodPhoto" class="col-md-2 text-right">宠粮照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="food_foodPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="food_foodPhoto" name="food.foodPhoto"/>
					    <input id="foodPhotoFile" name="foodPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="food_foodDesc" class="col-md-2 text-right">宠粮介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="food.foodDesc" id="food_foodDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="food_foodNum" class="col-md-2 text-right">库存数量:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="food_foodNum" name="food.foodNum" class="form-control" placeholder="请输入库存数量">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="food_addDateDiv" class="col-md-2 text-right">上架日期:</label>
				  	 <div class="col-md-8">
		                <div id="food_addDateDiv" class="input-group date food_addDate col-md-12" data-link-field="food_addDate" data-link-format="yyyy-mm-dd">
		                    <input class="form-control" id="food_addDate" name="food.addDate" size="16" type="text" value="" placeholder="请选择上架日期" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxFoodAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#foodAddForm .form-group {margin:5px;}  </style>  
				</form> 
			</div>
			<div class="col-md-2"></div> 
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
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var food_foodDesc_editor = UE.getEditor('food_foodDesc'); //宠粮介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加宠物粮食信息
	function ajaxFoodAdd() { 
		//提交之前先验证表单
		$("#foodAddForm").data('bootstrapValidator').validate();
		if(!$("#foodAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(food_foodDesc_editor.getContent() == "") {
			alert('宠粮介绍不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Food/add",
			dataType : "json" , 
			data: new FormData($("#foodAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#foodAddForm").find("input").val("");
					$("#foodAddForm").find("textarea").val("");
					food_foodDesc_editor.setContent("");
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
	//验证宠物粮食添加表单字段
	$('#foodAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"food.foodName": {
				validators: {
					notEmpty: {
						message: "宠粮名称不能为空",
					}
				}
			},
			"food.foodNum": {
				validators: {
					notEmpty: {
						message: "库存数量不能为空",
					},
					integer: {
						message: "库存数量不正确"
					}
				}
			},
			"food.addDate": {
				validators: {
					notEmpty: {
						message: "上架日期不能为空",
					}
				}
			},
		}
	}); 
	//上架日期组件
	$('#food_addDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#foodAddForm').data('bootstrapValidator').updateStatus('food.addDate', 'NOT_VALIDATED',null).validateField('food.addDate');
	});
})
</script>
</body>
</html>
