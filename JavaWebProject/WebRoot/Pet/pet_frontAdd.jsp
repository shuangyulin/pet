<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.PetClass" %>
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
<title>宠物添加</title>
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
  			<li><a href="<%=basePath %>Pet/frontlist">宠物管理</a></li>
  			<li class="active">添加宠物</li>
		</ul>
		<div class="row">
			<div class="col-md-10">
		      	<form class="form-horizontal" name="petAddForm" id="petAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
				  <div class="form-group">
				  	 <label for="pet_petClassObj_petClassId" class="col-md-2 text-right">宠物类别:</label>
				  	 <div class="col-md-8">
					    <select id="pet_petClassObj_petClassId" name="pet.petClassObj.petClassId" class="form-control">
					    </select>
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="pet_petName" class="col-md-2 text-right">宠物名称:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="pet_petName" name="pet.petName" class="form-control" placeholder="请输入宠物名称">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="pet_petPhoto" class="col-md-2 text-right">宠物照片:</label>
				  	 <div class="col-md-8">
					    <img  class="img-responsive" id="pet_petPhotoImg" border="0px"/><br/>
					    <input type="hidden" id="pet_petPhoto" name="pet.petPhoto"/>
					    <input id="petPhotoFile" name="petPhotoFile" type="file" size="50" />
				  	 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="pet_petDesc" class="col-md-2 text-right">宠物介绍:</label>
				  	 <div class="col-md-8">
							    <textarea name="pet.petDesc" id="pet_petDesc" style="width:100%;height:500px;"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="pet_petRequest" class="col-md-2 text-right">领养要求:</label>
				  	 <div class="col-md-8">
					    <textarea id="pet_petRequest" name="pet.petRequest" rows="8" class="form-control" placeholder="请输入领养要求"></textarea>
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="pet_petState" class="col-md-2 text-right">领养状态:</label>
				  	 <div class="col-md-8">
					    <input type="text" id="pet_petState" name="pet.petState" class="form-control" placeholder="请输入领养状态">
					 </div>
				  </div>
				  <div class="form-group">
				  	 <label for="pet_addTimeDiv" class="col-md-2 text-right">登记时间:</label>
				  	 <div class="col-md-8">
		                <div id="pet_addTimeDiv" class="input-group date pet_addTime col-md-12" data-link-field="pet_addTime">
		                    <input class="form-control" id="pet_addTime" name="pet.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
		                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		                </div>
				  	 </div>
				  </div>
		          <div class="form-group">
		             <span class="col-md-2""></span>
		             <span onclick="ajaxPetAdd();" class="btn btn-primary bottom5 top5">添加</span>
		          </div> 
		          <style>#petAddForm .form-group {margin:5px;}  </style>  
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
var pet_petDesc_editor = UE.getEditor('pet_petDesc'); //宠物介绍编辑器
var basePath = "<%=basePath%>";
	//提交添加宠物信息
	function ajaxPetAdd() { 
		//提交之前先验证表单
		$("#petAddForm").data('bootstrapValidator').validate();
		if(!$("#petAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(pet_petDesc_editor.getContent() == "") {
			alert('宠物介绍不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Pet/add",
			dataType : "json" , 
			data: new FormData($("#petAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#petAddForm").find("input").val("");
					$("#petAddForm").find("textarea").val("");
					pet_petDesc_editor.setContent("");
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
	//验证宠物添加表单字段
	$('#petAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"pet.petName": {
				validators: {
					notEmpty: {
						message: "宠物名称不能为空",
					}
				}
			},
			"pet.petRequest": {
				validators: {
					notEmpty: {
						message: "领养要求不能为空",
					}
				}
			},
			"pet.petState": {
				validators: {
					notEmpty: {
						message: "领养状态不能为空",
					}
				}
			},
			"pet.addTime": {
				validators: {
					notEmpty: {
						message: "登记时间不能为空",
					}
				}
			},
		}
	}); 
	//初始化宠物类别下拉框值 
	$.ajax({
		url: basePath + "PetClass/listAll",
		type: "get",
		success: function(petClasss,response,status) { 
			$("#pet_petClassObj_petClassId").empty();
			var html="";
    		$(petClasss).each(function(i,petClass){
    			html += "<option value='" + petClass.petClassId + "'>" + petClass.petClassName + "</option>";
    		});
    		$("#pet_petClassObj_petClassId").html(html);
    	}
	});
	//登记时间组件
	$('#pet_addTimeDiv').datetimepicker({
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
		$('#petAddForm').data('bootstrapValidator').updateStatus('pet.addTime', 'NOT_VALIDATED',null).validateField('pet.addTime');
	});
})
</script>
</body>
</html>
