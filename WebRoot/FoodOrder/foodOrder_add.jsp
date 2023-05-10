<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/foodOrder.css" />
<div id="foodOrderAddDiv">
	<form id="foodOrderAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠粮名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_foodObj_foodId" name="foodOrder.foodObj.foodId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预订用户:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_userObj_user_name" name="foodOrder.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">预订数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderNumber" name="foodOrder.orderNumber" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">订单状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderState" name="foodOrder.orderState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">预订时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="foodOrder_orderTime" name="foodOrder.orderTime" />

			</span>

		</div>
		<div class="operation">
			<a id="foodOrderAddButton" class="easyui-linkbutton">添加</a>
			<a id="foodOrderClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/FoodOrder/js/foodOrder_add.js"></script> 
