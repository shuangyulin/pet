$(function () {
	$.ajax({
		url : "PetClass/" + $("#petClass_petClassId_edit").val() + "/update",
		type : "get",
		data : {
			//petClassId : $("#petClass_petClassId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (petClass, response, status) {
			$.messager.progress("close");
			if (petClass) { 
				$("#petClass_petClassId_edit").val(petClass.petClassId);
				$("#petClass_petClassId_edit").validatebox({
					required : true,
					missingMessage : "请输入宠物类别id",
					editable: false
				});
				$("#petClass_petClassName_edit").val(petClass.petClassName);
				$("#petClass_petClassName_edit").validatebox({
					required : true,
					missingMessage : "请输入宠物类别名称",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#petClassModifyButton").click(function(){ 
		if ($("#petClassEditForm").form("validate")) {
			$("#petClassEditForm").form({
			    url:"PetClass/" +  $("#petClass_petClassId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#petClassEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#petClassEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
