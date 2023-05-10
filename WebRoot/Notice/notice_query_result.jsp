<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notice.css" /> 

<div id="notice_manage"></div>
<div id="notice_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="notice_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="notice_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="notice_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="notice_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="notice_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="noticeQueryForm" method="post">
			标题：<input type="text" class="textbox" id="noticeTitle" name="noticeTitle" style="width:110px" />
			公告类别：<input type="text" class="textbox" id="noticeClass" name="noticeClass" style="width:110px" />
			发布日期：<input type="text" id="addDate" name="addDate" class="easyui-datebox" editable="false" style="width:100px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="notice_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="noticeEditDiv">
	<form id="noticeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">公告id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeId_edit" name="notice.noticeId" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeTitle_edit" name="notice.noticeTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公告类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeClass_edit" name="notice.noticeClass" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公告内容:</span>
			<span class="inputControl">
				<script name="notice.noticeContent" id="notice_noticeContent_edit" type="text/plain"   style="width:100%;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_addDate_edit" name="notice.addDate" />

			</span>

		</div>
	</form>
</div>
<script>
//实例化编辑器
//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
var notice_noticeContent_editor = UE.getEditor('notice_noticeContent_edit'); //公告内容编辑器
</script>
<script type="text/javascript" src="Notice/js/notice_manage.js"></script> 
