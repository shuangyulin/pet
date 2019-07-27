<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pet.css" />
<div id="pet_editDiv">
	<form id="petEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠物id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_petId_edit" name="pet.petId" value="<%=request.getParameter("petId") %>" style="width:200px" />
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
				<script id="pet_petDesc_edit" name="pet.petDesc" type="text/plain"   style="width:750px;height:500px;"></script>

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
		<div class="operation">
			<a id="petModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Pet/js/pet_modify.js"></script> 
