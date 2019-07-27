<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/foodOrder.css" />
<div id="foodOrder_editDiv">
	<form id="foodOrderEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">订单id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderId_edit" name="foodOrder.orderId" value="<%=request.getParameter("orderId") %>" style="width:200px" />
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
		<div class="operation">
			<a id="foodOrderModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/FoodOrder/js/foodOrder_modify.js"></script> 
