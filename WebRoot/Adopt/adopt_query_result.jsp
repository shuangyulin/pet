<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/adopt.css" /> 

<div id="adopt_manage"></div>
<div id="adopt_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="adopt_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="adopt_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="adopt_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="adopt_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="adopt_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="adoptQueryForm" method="post">
			被领养宠物：<input class="textbox" type="text" id="petObj_petId_query" name="petObj.petId" style="width: auto"/>
			领养人：<input class="textbox" type="text" id="userObj_user_name_query" name="userObj.user_name" style="width: auto"/>
			领养申请时间：<input type="text" id="addTime" name="addTime" class="easyui-datebox" editable="false" style="width:100px">
			审核状态：<input type="text" class="textbox" id="shenHe" name="shenHe" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="adopt_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="adoptEditDiv">
	<form id="adoptEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">领养id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="adopt_adoptId_edit" name="adopt.adoptId" style="width:200px" />
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
	</form>
</div>
<script type="text/javascript" src="Adopt/js/adopt_manage.js"></script> 
