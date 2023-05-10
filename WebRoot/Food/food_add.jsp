<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/food.css" />
<div id="foodAddDiv">
	<form id="foodAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠粮名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_foodName" name="food.foodName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">宠粮照片:</span>
			<span class="inputControl">
				<input id="foodPhotoFile" name="foodPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">宠粮介绍:</span>
			<span class="inputControl">
				<script name="food.foodDesc" id="food_foodDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">库存数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_foodNum" name="food.foodNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">上架日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_addDate" name="food.addDate" />

			</span>

		</div>
		<div class="operation">
			<a id="foodAddButton" class="easyui-linkbutton">添加</a>
			<a id="foodClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Food/js/food_add.js"></script> 
