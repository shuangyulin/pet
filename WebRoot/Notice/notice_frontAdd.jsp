<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>公告信息添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Notice/frontlist">公告信息列表</a></li>
			    	<li role="presentation" class="active"><a href="#noticeAdd" aria-controls="noticeAdd" role="tab" data-toggle="tab">添加公告信息</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="noticeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="noticeAdd"> 
				      	<form class="form-horizontal" name="noticeAddForm" id="noticeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="notice_noticeTitle" class="col-md-2 text-right">标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="notice_noticeTitle" name="notice.noticeTitle" class="form-control" placeholder="请输入标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="notice_noticeClass" class="col-md-2 text-right">公告类别:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="notice_noticeClass" name="notice.noticeClass" class="form-control" placeholder="请输入公告类别">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="notice_noticeContent" class="col-md-2 text-right">公告内容:</label>
						  	 <div class="col-md-8">
							    <textarea name="notice.noticeContent" id="notice_noticeContent" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="notice_addDateDiv" class="col-md-2 text-right">发布日期:</label>
						  	 <div class="col-md-8">
				                <div id="notice_addDateDiv" class="input-group date notice_addDate col-md-12" data-link-field="notice_addDate" data-link-format="yyyy-mm-dd">
				                    <input class="form-control" id="notice_addDate" name="notice.addDate" size="16" type="text" value="" placeholder="请选择发布日期" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxNoticeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#noticeAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var notice_noticeContent_editor = UE.getEditor('notice_noticeContent'); //公告内容编辑器
var basePath = "<%=basePath%>";
	//提交添加公告信息信息
	function ajaxNoticeAdd() { 
		//提交之前先验证表单
		$("#noticeAddForm").data('bootstrapValidator').validate();
		if(!$("#noticeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(notice_noticeContent_editor.getContent() == "") {
			alert('公告内容不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Notice/add",
			dataType : "json" , 
			data: new FormData($("#noticeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#noticeAddForm").find("input").val("");
					$("#noticeAddForm").find("textarea").val("");
					notice_noticeContent_editor.setContent("");
				} else {
					alert(obj.message);
				}
			},
			processData: false, 
			contentType: false, 
		});
	} 
$(function(){
	/*小屏幕导航点击关闭菜单*/
    $('.navbar-collapse a').click(function(){
        $('.navbar-collapse').collapse('hide');
    });
    new WOW().init();
	//验证公告信息添加表单字段
	$('#noticeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"notice.noticeTitle": {
				validators: {
					notEmpty: {
						message: "标题不能为空",
					}
				}
			},
			"notice.noticeClass": {
				validators: {
					notEmpty: {
						message: "公告类别不能为空",
					}
				}
			},
			"notice.addDate": {
				validators: {
					notEmpty: {
						message: "发布日期不能为空",
					}
				}
			},
		}
	}); 
	//发布日期组件
	$('#notice_addDateDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd',
		minView: 2,
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#noticeAddForm').data('bootstrapValidator').updateStatus('notice.addDate', 'NOT_VALIDATED',null).validateField('notice.addDate');
	});
})
</script>
</body>
</html>
