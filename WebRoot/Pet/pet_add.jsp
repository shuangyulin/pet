<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pet.css" />
<div id="petAddDiv">
	<form id="petAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠物类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_petClassObj_petClassId" name="pet.petClassObj.petClassId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">宠物名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_petName" name="pet.petName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">宠物照片:</span>
			<span class="inputControl">
				<input id="petPhotoFile" name="petPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">宠物介绍:</span>
			<span class="inputControl">
				<script name="pet.petDesc" id="pet_petDesc" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">领养要求:</span>
			<span class="inputControl">
				<textarea id="pet_petRequest" name="pet.petRequest" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">领养状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_petState" name="pet.petState" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登记时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="pet_addTime" name="pet.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="petAddButton" class="easyui-linkbutton">添加</a>
			<a id="petClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Pet/js/pet_add.js"></script> 
