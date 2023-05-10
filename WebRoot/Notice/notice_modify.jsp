<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notice.css" />
<div id="notice_editDiv">
	<form id="noticeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">公告id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeId_edit" name="notice.noticeId" value="<%=request.getParameter("noticeId") %>" style="width:200px" />
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
				<script id="notice_noticeContent_edit" name="notice.noticeContent" type="text/plain"   style="width:750px;height:500px;"></script>

			</span>

		</div>
		<div>
			<span class="label">发布日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_addDate_edit" name="notice.addDate" />

			</span>

		</div>
		<div class="operation">
			<a id="noticeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Notice/js/notice_modify.js"></script> 
