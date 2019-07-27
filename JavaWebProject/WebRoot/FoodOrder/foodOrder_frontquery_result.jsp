<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.FoodOrder" %>
<%@ page import="com.chengxusheji.po.Food" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<FoodOrder> foodOrderList = (List<FoodOrder>)request.getAttribute("foodOrderList");
    //获取所有的foodObj信息
    List<Food> foodList = (List<Food>)request.getAttribute("foodList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Food foodObj = (Food)request.getAttribute("foodObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String orderState = (String)request.getAttribute("orderState"); //订单状态查询关键字
    String orderTime = (String)request.getAttribute("orderTime"); //预订时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>宠粮订单查询</title>
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
			    	<li role="presentation" class="active"><a href="#foodOrderListPanel" aria-controls="foodOrderListPanel" role="tab" data-toggle="tab">宠粮订单列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>FoodOrder/foodOrder_frontAdd.jsp" style="display:none;">添加宠粮订单</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="foodOrderListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>订单id</td><td>宠粮名称</td><td>预订用户</td><td>预订数量</td><td>订单状态</td><td>预订时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<foodOrderList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		FoodOrder foodOrder = foodOrderList.get(i); //获取到宠粮订单对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=foodOrder.getOrderId() %></td>
 											<td><%=foodOrder.getFoodObj().getFoodName() %></td>
 											<td><%=foodOrder.getUserObj().getName() %></td>
 											<td><%=foodOrder.getOrderNumber() %></td>
 											<td><%=foodOrder.getOrderState() %></td>
 											<td><%=foodOrder.getOrderTime() %></td>
 											<td>
 												<a href="<%=basePath  %>FoodOrder/<%=foodOrder.getOrderId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="foodOrderEdit('<%=foodOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="foodOrderDelete('<%=foodOrder.getOrderId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>宠粮订单查询</h1>
		</div>
		<form name="foodOrderQueryForm" id="foodOrderQueryForm" action="<%=basePath %>FoodOrder/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="foodObj_foodId">宠粮名称：</label>
                <select id="foodObj_foodId" name="foodObj.foodId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(Food foodTemp:foodList) {
	 					String selected = "";
 					if(foodObj!=null && foodObj.getFoodId()!=null && foodObj.getFoodId().intValue()==foodTemp.getFoodId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=foodTemp.getFoodId() %>" <%=selected %>><%=foodTemp.getFoodName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">预订用户：</label>
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
				<label for="orderState">订单状态:</label>
				<input type="text" id="orderState" name="orderState" value="<%=orderState %>" class="form-control" placeholder="请输入订单状态">
			</div>






			<div class="form-group">
				<label for="orderTime">预订时间:</label>
				<input type="text" id="orderTime" name="orderTime" class="form-control"  placeholder="请选择预订时间" value="<%=orderTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="foodOrderEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;宠粮订单信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#foodOrderEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxFoodOrderModify();">提交</button>
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
    document.foodOrderQueryForm.currentPage.value = currentPage;
    document.foodOrderQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.foodOrderQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.foodOrderQueryForm.currentPage.value = pageValue;
    documentfoodOrderQueryForm.submit();
}

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
				$('#foodOrderEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除宠粮订单信息*/
function foodOrderDelete(orderId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "FoodOrder/deletes",
			data : {
				orderIds : orderId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#foodOrderQueryForm").submit();
					//location.href= basePath + "FoodOrder/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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
})
</script>
</body>
</html>

