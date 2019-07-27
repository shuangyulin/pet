<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/petClass.css" />
<div id="petClass_editDiv">
	<form id="petClassEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠物类别id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="petClass_petClassId_edit" name="petClass.petClassId" value="<%=request.getParameter("petClassId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">宠物类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="petClass_petClassName_edit" name="petClass.petClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="petClassModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/PetClass/js/petClass_modify.js"></script> 
