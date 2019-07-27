<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adopt.css" />
<div id="adoptAddDiv">
	<form id="adoptAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">被领养宠物:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_petObj_petId" name="adopt.petObj.petId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">领养人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_userObj_user_name" name="adopt.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">领养申请时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_addTime" name="adopt.addTime" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_shenHe" name="adopt.shenHe" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="adoptAddButton" class="easyui-linkbutton">添加</a>
			<a id="adoptClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Adopt/js/adopt_add.js"></script> 
