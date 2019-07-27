$(function () {
	$.ajax({
		url : "Adopt/" + $("#adopt_adoptId_edit").val() + "/update",
		type : "get",
		data : {
			//adoptId : $("#adopt_adoptId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (adopt, response, status) {
			$.messager.progress("close");
			if (adopt) { 
				$("#adopt_adoptId_edit").val(adopt.adoptId);
				$("#adopt_adoptId_edit").validatebox({
					required : true,
					missingMessage : "请输入领养id",
					editable: false
				});
				$("#adopt_petObj_petId_edit").combobox({
					url:"Pet/listAll",
					valueField:"petId",
					textField:"petName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#adopt_petObj_petId_edit").combobox("select", adopt.petObjPri);
						//var data = $("#adopt_petObj_petId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#adopt_petObj_petId_edit").combobox("select", data[0].petId);
						//}
					}
				});
				$("#adopt_userObj_user_name_edit").combobox({
					url:"UserInfo/listAll",
					valueField:"user_name",
					textField:"name",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#adopt_userObj_user_name_edit").combobox("select", adopt.userObjPri);
						//var data = $("#adopt_userObj_user_name_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#adopt_userObj_user_name_edit").combobox("select", data[0].user_name);
						//}
					}
				});
				$("#adopt_addTime_edit").datetimebox({
					value: adopt.addTime,
					required: true,
					showSeconds: true,
				});
				$("#adopt_shenHe_edit").val(adopt.shenHe);
				$("#adopt_shenHe_edit").validatebox({
					required : true,
					missingMessage : "请输入审核状态",
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#adoptModifyButton").click(function(){ 
		if ($("#adoptEditForm").form("validate")) {
			$("#adoptEditForm").form({
			    url:"Adopt/" +  $("#adopt_adoptId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#adoptEditForm").form("validate"))  {
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
			$("#adoptEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
