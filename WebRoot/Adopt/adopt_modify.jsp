<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adopt.css" />
<div id="adopt_editDiv">
	<form id="adoptEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">领养id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_adoptId_edit" name="adopt.adoptId" value="<%=request.getParameter("adoptId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">被领养宠物:</span>
			<span class="inputControl">
				<input class="textbox"  id="adopt_petObj_petId_edit" name="adopt.petObj.petId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">领养人:</span>
			<span class="inputControl">
				<input class="textbox"  id="adopt_userObj_user_name_edit" name="adopt.userObj.user_name" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">领养申请时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_addTime_edit" name="adopt.addTime" />

			</span>

		</div>
		<div>
			<span class="label">审核状态:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_shenHe_edit" name="adopt.shenHe" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="adoptModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Adopt/js/adopt_modify.js"></script> 
