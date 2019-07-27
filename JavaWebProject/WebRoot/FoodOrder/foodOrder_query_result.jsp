<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/foodOrder.css" /> 

<div id="foodOrder_manage"></div>
<div id="foodOrder_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="foodOrder_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="foodOrder_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="foodOrder_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="foodOrder_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="foodOrder_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="foodOrderQueryForm" method="post">
			宠粮名称：<input class="textbox" type="text" id="foodObj_foodId_query" name="foodObj.foodId" style="width: auto"/>
			预订用户：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			订单状态：<input type="text" class="textbox" id="orderState" name="orderState" style="width:110px" />
			预订时间：<input type="text" id="orderTime" name="orderTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="foodOrder_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="foodOrderEditDiv">
	<form id="foodOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderId_edit" name="foodOrder.orderId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">宠粮名称:</span>
			<span class="inputControl">
				<input class="textbox"  id="foodOrder_foodObj_foodId_edit" name="foodOrder.foodObj.foodId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预订用户:</span>
			<span class="inputControl">
				<input class="textbox"  id="foodOrder_userObj_user_name_edit" name="foodOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预订数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderNumber_edit" name="foodOrder.orderNumber" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderState_edit" name="foodOrder.orderState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">预订时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderTime_edit" name="foodOrder.orderTime" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="FoodOrder/js/foodOrder_manage.js"></script> 
