<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/notice.css" />
<div id="noticeAddDiv">
	<form id="noticeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">标题:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeTitle" name="notice.noticeTitle" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公告类别:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_noticeClass" name="notice.noticeClass" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">公告内容:</span>
			<span class="inputControl">
				<script name="notice.noticeContent" id="notice_noticeContent" type="text/plain"   style="width:750px;height:500px;"></script>
			</span>

		</div>
		<div>
			<span class="label">发布日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="notice_addDate" name="notice.addDate" />

			</span>

		</div>
		<div class="operation">
			<a id="noticeAddButton" class="easyui-linkbutton">添加</a>
			<a id="noticeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/Notice/js/notice_add.js"></script> 
