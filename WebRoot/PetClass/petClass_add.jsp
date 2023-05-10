<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/petClass.css" />
<div id="petClassAddDiv">
	<form id="petClassAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">宠物类别名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="petClass_petClassName" name="petClass.petClassName" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="petClassAddButton" class="easyui-linkbutton">添加</a>
			<a id="petClassClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/PetClass/js/petClass_add.js"></script> 
