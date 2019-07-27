$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('pet_petDesc_edit');
	var pet_petDesc_edit = UE.getEditor('pet_petDesc_edit'); //宠物介绍编辑器
	pet_petDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Pet/" + $("#pet_petId_edit").val() + "/update",
		type : "get",
		data : {
			//petId : $("#pet_petId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (pet, response, status) {
			$.messager.progress("close");
			if (pet) { 
				$("#pet_petId_edit").val(pet.petId);
				$("#pet_petId_edit").validatebox({
					required : true,
					missingMessage : "请输入宠物id",
					editable: false
				});
				$("#pet_petClassObj_petClassId_edit").combobox({
					url:"PetClass/listAll",
					valueField:"petClassId",
					textField:"petClassName",
					panelHeight: "auto",
					editable: false, //不允许手动输入 
					onLoadSuccess: function () { //数据加载完毕事件
						$("#pet_petClassObj_petClassId_edit").combobox("select", pet.petClassObjPri);
						//var data = $("#pet_petClassObj_petClassId_edit").combobox("getData"); 
						//if (data.length > 0) {
							//$("#pet_petClassObj_petClassId_edit").combobox("select", data[0].petClassId);
						//}
					}
				});
				$("#pet_petName_edit").val(pet.petName);
				$("#pet_petName_edit").validatebox({
					required : true,
					missingMessage : "请输入宠物名称",
				});
				$("#pet_petPhoto").val(pet.petPhoto);
				$("#pet_petPhotoImg").attr("src", pet.petPhoto);
				pet_petDesc_edit.setContent(pet.petDesc);
				$("#pet_petRequest_edit").val(pet.petRequest);
				$("#pet_petRequest_edit").validatebox({
					required : true,
					missingMessage : "请输入领养要求",
				});
				$("#pet_petState_edit").val(pet.petState);
				$("#pet_petState_edit").validatebox({
					required : true,
					missingMessage : "请输入领养状态",
				});
				$("#pet_addTime_edit").datetimebox({
					value: pet.addTime,
					required: true,
					showSeconds: true,
				});
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

  }

	$("#petModifyButton").click(function(){ 
		if ($("#petEditForm").form("validate")) {
			$("#petEditForm").form({
			    url:"Pet/" +  $("#pet_petId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#petEditForm").form("validate"))  {
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
			$("#petEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
