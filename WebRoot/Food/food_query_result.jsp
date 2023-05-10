<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/food.css" /> 

<div id="food_manage"></div>
<div id="food_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="food_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="food_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="food_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="food_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="food_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="foodQueryForm" method="post">
			宠粮名称：<input type="text" class="textbox" id="foodName" name="foodName" style="width:110px" />
			上架日期：<input type="text" id="addDate" name="addDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="food_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="foodEditDiv">
	<form id="foodEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠粮id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="food_foodId_edit" name="food.foodId" style="width:200px" />
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
				<script name="food.foodDesc" id="food_foodDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

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
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var food_foodDesc_editor = UE.getEditor('food_foodDesc_edit'); //宠粮介绍编辑器
</script>
<script type="text/javascript" src="Food/js/food_manage.js"></script> 
