<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Adopt" %>
<%@ page import="com.chengxusheji.po.Pet" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Adopt> adoptList = (List<Adopt>)request.getAttribute("adoptList");
    //获取所有的petObj信息
    List<Pet> petList = (List<Pet>)request.getAttribute("petList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Pet petObj = (Pet)request.getAttribute("petObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String addTime = (String)request.getAttribute("addTime"); //领养申请时间查询关键字
    String shenHe = (String)request.getAttribute("shenHe"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>领养查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#adoptListPanel" aria-controls="adoptListPanel" role="tab" data-toggle="tab">领养列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Adopt/adopt_frontAdd.jsp" style="display:none;">添加领养</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="adoptListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>领养id</td><td>被领养宠物</td><td>领养人</td><td>领养申请时间</td><td>审核状态</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<adoptList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Adopt adopt = adoptList.get(i); //获取到领养对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=adopt.getAdoptId() %></td>
 											<td><%=adopt.getPetObj().getPetName() %></td>
 											<td><%=adopt.getUserObj().getName() %></td>
 											<td><%=adopt.getAddTime() %></td>
 											<td><%=adopt.getShenHe() %></td>
 											<td>
 												<a href="<%=basePath  %>Adopt/<%=adopt.getAdoptId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="adoptEdit('<%=adopt.getAdoptId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="adoptDelete('<%=adopt.getAdoptId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

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
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>领养查询</h1>
		</div>
		<form name="adoptQueryForm" id="adoptQueryForm" action="<%=basePath %>Adopt/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="petObj_petId">被领养宠物：</label>
                <select id="petObj_petId" name="petObj.petId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Pet petTemp:petList) {
	 					String selected = "";
 					if(petObj!=null && petObj.getPetId()!=null && petObj.getPetId().intValue()==petTemp.getPetId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=petTemp.getPetId() %>" <%=selected %>><%=petTemp.getPetName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">领养人：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="addTime">领养申请时间:</label>
				<input type="text" id="addTime" name="addTime" class="form-control"  placeholder="请选择领养申请时间" value="<%=addTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="shenHe">审核状态:</label>
				<input type="text" id="shenHe" name="shenHe" value="<%=shenHe %>" class="form-control" placeholder="请输入审核状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="adoptEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;领养信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#adoptEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxAdoptModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.adoptQueryForm.currentPage.value = currentPage;
    document.adoptQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.adoptQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.adoptQueryForm.currentPage.value = pageValue;
    documentadoptQueryForm.submit();
}

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
				$('#adoptEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除领养信息*/
function adoptDelete(adoptId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Adopt/deletes",
			data : {
				adoptIds : adoptId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#adoptQueryForm").submit();
					//location.href= basePath + "Adopt/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

