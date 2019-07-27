<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pet.css" /> 

<div id="pet_manage"></div>
<div id="pet_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="pet_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="pet_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="pet_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="pet_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="pet_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="petQueryForm" method="post">
			宠物类别：<input class="textbox" type="text" id="petClassObj_petClassId_query" name="petClassObj.petClassId" style="width: auto"/>
			宠物名称：<input type="text" class="textbox" id="petName" name="petName" style="width:110px" />
			领养状态：<input type="text" class="textbox" id="petState" name="petState" style="width:110px" />
			登记时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="pet_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="petEditDiv">
	<form id="petEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠物id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_petId_edit" name="pet.petId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">宠物类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="pet_petClassObj_petClassId_edit" name="pet.petClassObj.petClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">宠物名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_petName_edit" name="pet.petName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">宠物照片:</span>
			<span class="inputControl">
				<img id="pet_petPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="pet_petPhoto" name="pet.petPhoto"/>
				<input id="petPhotoFile" name="petPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">宠物介绍:</span>
			<span class="inputControl">
				<script name="pet.petDesc" id="pet_petDesc_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">领养要求:</span>
			<span class="inputControl">
				<textarea id="pet_petRequest_edit" name="pet.petRequest" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">领养状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_petState_edit" name="pet.petState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_addTime_edit" name="pet.addTime" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var pet_petDesc_editor = UE.getEditor('pet_petDesc_edit'); //宠物介绍编辑器
</script>
<script type="text/javascript" src="Pet/js/pet_manage.js"></script> 
