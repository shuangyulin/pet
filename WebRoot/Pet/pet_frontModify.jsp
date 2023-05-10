<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Pet" %>
<%@ page import="com.chengxusheji.po.PetClass" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的petClassObj信息
    List<PetClass> petClassList = (List<PetClass>)request.getAttribute("petClassList");
    Pet pet = (Pet)request.getAttribute("pet");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改宠物信息</TITLE>
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
  		<li class="active">宠物信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="petEditForm" id="petEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="pet_petId_edit" class="col-md-3 text-right">宠物id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="pet_petId_edit" name="pet.petId" class="form-control" placeholder="请输入宠物id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="pet_petClassObj_petClassId_edit" class="col-md-3 text-right">宠物类别:</label>
		  	 <div class="col-md-9">
			    <select id="pet_petClassObj_petClassId_edit" name="pet.petClassObj.petClassId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="pet_petName_edit" class="col-md-3 text-right">宠物名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="pet_petName_edit" name="pet.petName" class="form-control" placeholder="请输入宠物名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="pet_petPhoto_edit" class="col-md-3 text-right">宠物照片:</label>
		  	 <div class="col-md-9">
			    <img  class="img-responsive" id="pet_petPhotoImg" border="0px"/><br/>
			    <input type="hidden" id="pet_petPhoto" name="pet.petPhoto"/>
			    <input id="petPhotoFile" name="petPhotoFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="pet_petDesc_edit" class="col-md-3 text-right">宠物介绍:</label>
		  	 <div class="col-md-9">
			    <script name="pet.petDesc" id="pet_petDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="pet_petRequest_edit" class="col-md-3 text-right">领养要求:</label>
		  	 <div class="col-md-9">
			    <textarea id="pet_petRequest_edit" name="pet.petRequest" rows="8" class="form-control" placeholder="请输入领养要求"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="pet_petState_edit" class="col-md-3 text-right">领养状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="pet_petState_edit" name="pet.petState" class="form-control" placeholder="请输入领养状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="pet_addTime_edit" class="col-md-3 text-right">登记时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date pet_addTime_edit col-md-12" data-link-field="pet_addTime_edit">
                    <input class="form-control" id="pet_addTime_edit" name="pet.addTime" size="16" type="text" value="" placeholder="请选择登记时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxPetModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#petEditForm .form-group {margin-bottom:5px;}  </style>
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
var pet_petDesc_editor = UE.getEditor('pet_petDesc_edit'); //宠物介绍编辑框
var basePath = "<%=basePath%>";
/*弹出修改宠物界面并初始化数据*/
function petEdit(petId) {
  pet_petDesc_editor.addListener("ready", function () {
    // editor准备好之后才可以使用 
    ajaxModifyQuery(petId);
  });
}
 function ajaxModifyQuery(petId) {
	$.ajax({
		url :  basePath + "Pet/" + petId + "/update",
		type : "get",
		dataType: "json",
		success : function (pet, response, status) {
			if (pet) {
				$("#pet_petId_edit").val(pet.petId);
				$.ajax({
					url: basePath + "PetClass/listAll",
					type: "get",
					success: function(petClasss,response,status) { 
						$("#pet_petClassObj_petClassId_edit").empty();
						var html="";
		        		$(petClasss).each(function(i,petClass){
		        			html += "<option value='" + petClass.petClassId + "'>" + petClass.petClassName + "</option>";
		        		});
		        		$("#pet_petClassObj_petClassId_edit").html(html);
		        		$("#pet_petClassObj_petClassId_edit").val(pet.petClassObjPri);
					}
				});
				$("#pet_petName_edit").val(pet.petName);
				$("#pet_petPhoto").val(pet.petPhoto);
				$("#pet_petPhotoImg").attr("src", basePath +　pet.petPhoto);
				pet_petDesc_editor.setContent(pet.petDesc, false);
				$("#pet_petRequest_edit").val(pet.petRequest);
				$("#pet_petState_edit").val(pet.petState);
				$("#pet_addTime_edit").val(pet.addTime);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交宠物信息表单给服务器端修改*/
function ajaxPetModify() {
	$.ajax({
		url :  basePath + "Pet/" + $("#pet_petId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#petEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#petQueryForm").submit();
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
    /*登记时间组件*/
    $('.pet_addTime_edit').datetimepicker({
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
    petEdit("<%=request.getParameter("petId")%>");
 })
 </script> 
</body>
</html>

