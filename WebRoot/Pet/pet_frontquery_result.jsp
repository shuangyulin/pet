<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Pet" %>
<%@ page import="com.chengxusheji.po.PetClass" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Pet> petList = (List<Pet>)request.getAttribute("petList");
    //获取所有的petClassObj信息
    List<PetClass> petClassList = (List<PetClass>)request.getAttribute("petClassList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    PetClass petClassObj = (PetClass)request.getAttribute("petClassObj");
    String petName = (String)request.getAttribute("petName"); //宠物名称查询关键字
    String petState = (String)request.getAttribute("petState"); //领养状态查询关键字
    String addTime = (String)request.getAttribute("addTime"); //登记时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>宠物查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
		<ul class="breadcrumb">
  			<li><a href="<%=basePath %>index.jsp">首页</a></li>
  			<li><a href="<%=basePath %>Pet/frontlist">宠物信息列表</a></li>
  			<li class="active">查询结果显示</li>
  			<a class="pull-right" href="<%=basePath %>Pet/pet_frontAdd.jsp" style="display:none;">添加宠物</a>
		</ul>
		<div class="row">
			<%
				/*计算起始序号*/
				int startIndex = (currentPage -1) * 5;
				/*遍历记录*/
				for(int i=0;i<petList.size();i++) {
            		int currentIndex = startIndex + i + 1; //当前记录的序号
            		Pet pet = petList.get(i); //获取到宠物对象
            		String clearLeft = "";
            		if(i%4 == 0) clearLeft = "style=\"clear:left;\"";
			%>
			<div class="col-md-3 bottom15" <%=clearLeft %>>
			  <a  href="<%=basePath  %>Pet/<%=pet.getPetId() %>/frontshow"><img class="img-responsive" src="<%=basePath%><%=pet.getPetPhoto()%>" /></a>
			     <div class="showFields">
			     	<div class="field">
	            		宠物id:<%=pet.getPetId() %>
			     	</div>
			     	<div class="field">
	            		宠物类别:<%=pet.getPetClassObj().getPetClassName() %>
			     	</div>
			     	<div class="field">
	            		宠物名称:<%=pet.getPetName() %>
			     	</div>
			     	<div class="field">
	            		领养要求:<%=pet.getPetRequest() %>
			     	</div>
			     	<div class="field">
	            		领养状态:<%=pet.getPetState() %>
			     	</div>
			     	<div class="field">
	            		登记时间:<%=pet.getAddTime() %>
			     	</div>
			        <a class="btn btn-primary top5" href="<%=basePath %>Pet/<%=pet.getPetId() %>/frontshow">详情</a>
			        <a class="btn btn-primary top5" onclick="petEdit('<%=pet.getPetId() %>');" style="display:none;">修改</a>
			        <a class="btn btn-primary top5" onclick="petDelete('<%=pet.getPetId() %>');" style="display:none;">删除</a>
			     </div>
			</div>
			<%  } %>

			<div class="row">
				<div class="col-md-12">
					<nav class="pull-left">
						<ul class="pagination">
							<li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
							<%
								int startPage = currentPage - 5;
								int endPage = currentPage + 5;
								if(startPage < 1) startPage=1;
								if(endPage > totalPage) endPage = totalPage;
								for(int i=startPage;i<=endPage;i++) {
							%>
							<li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
							<%  } %> 
							<li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						</ul>
					</nav>
					<div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
				</div>
			</div>
		</div>
	</div>

	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>宠物查询</h1>
		</div>
		<form name="petQueryForm" id="petQueryForm" action="<%=basePath %>Pet/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="petClassObj_petClassId">宠物类别：</label>
                <select id="petClassObj_petClassId" name="petClassObj.petClassId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(PetClass petClassTemp:petClassList) {
	 					String selected = "";
 					if(petClassObj!=null && petClassObj.getPetClassId()!=null && petClassObj.getPetClassId().intValue()==petClassTemp.getPetClassId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=petClassTemp.getPetClassId() %>" <%=selected %>><%=petClassTemp.getPetClassName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="petName">宠物名称:</label>
				<input type="text" id="petName" name="petName" value="<%=petName %>" class="form-control" placeholder="请输入宠物名称">
			</div>
			<div class="form-group">
				<label for="petState">领养状态:</label>
				<input type="text" id="petState" name="petState" value="<%=petState %>" class="form-control" placeholder="请输入领养状态">
			</div>
			<div class="form-group">
				<label for="addTime">登记时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择登记时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
</div>
<div id="petEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;宠物信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
			 	<textarea name="pet.petDesc" id="pet_petDesc_edit" style="width:100%;height:500px;"></textarea>
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
		</form> 
	    <style>#petEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxPetModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
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
//实例化编辑器
var pet_petDesc_edit = UE.getEditor('pet_petDesc_edit'); //宠物介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.petQueryForm.currentPage.value = currentPage;
    document.petQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.petQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.petQueryForm.currentPage.value = pageValue;
    documentpetQueryForm.submit();
}

/*弹出修改宠物界面并初始化数据*/
function petEdit(petId) {
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
				pet_petDesc_edit.setContent(pet.petDesc, false);
				$("#pet_petRequest_edit").val(pet.petRequest);
				$("#pet_petState_edit").val(pet.petState);
				$("#pet_addTime_edit").val(pet.addTime);
				$('#petEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除宠物信息*/
function petDelete(petId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Pet/deletes",
			data : {
				petIds : petId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#petQueryForm").submit();
					//location.href= basePath + "Pet/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

