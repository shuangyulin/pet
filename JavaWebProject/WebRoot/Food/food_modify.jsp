<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/food.css" />
<div id="food_editDiv">
	<form id="foodEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠粮id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_foodId_edit" name="food.foodId" value="<%=request.getParameter("foodId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">宠粮名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_foodName_edit" name="food.foodName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">宠粮照片:</span>
			<span class="inputControl">
				<img id="food_foodPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="food_foodPhoto" name="food.foodPhoto"/>
				<input id="foodPhotoFile" name="foodPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">宠粮介绍:</span>
			<span class="inputControl">
				<script id="food_foodDesc_edit" name="food.foodDesc" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">库存数量:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_foodNum_edit" name="food.foodNum" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">上架日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_addDate_edit" name="food.addDate" />

			</span>

		</div>
		<div class="operation">
			<a id="foodModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Food/js/food_modify.js"></script> 
