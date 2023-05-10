$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('food_foodDesc_edit');
	var food_foodDesc_edit = UE.getEditor('food_foodDesc_edit'); //宠粮介绍编辑器
	food_foodDesc_edit.addListener("ready", function () {
		 // editor准备好之后才可以使用 
		 ajaxModifyQuery();
	}); 
  function ajaxModifyQuery() {	
	$.ajax({
		url : "Food/" + $("#food_foodId_edit").val() + "/update",
		type : "get",
		data : {
			//foodId : $("#food_foodId_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (food, response, status) {
			$.messager.progress("close");
			if (food) { 
				$("#food_foodId_edit").val(food.foodId);
				$("#food_foodId_edit").validatebox({
					required : true,
					missingMessage : "请输入宠粮id",
					editable: false
				});
				$("#food_foodName_edit").val(food.foodName);
				$("#food_foodName_edit").validatebox({
					required : true,
					missingMessage : "请输入宠粮名称",
				});
				$("#food_foodPhoto").val(food.foodPhoto);
				$("#food_foodPhotoImg").attr("src", food.foodPhoto);
				food_foodDesc_edit.setContent(food.foodDesc);
				$("#food_foodNum_edit").val(food.foodNum);
				$("#food_foodNum_edit").validatebox({
					required : true,
					validType : "integer",
					missingMessage : "请输入库存数量",
					invalidMessage : "库存数量输入不对",
				});
				$("#food_addDate_edit").datebox({
					value: food.addDate,
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

	$("#foodModifyButton").click(function(){ 
		if ($("#foodEditForm").form("validate")) {
			$("#foodEditForm").form({
			    url:"Food/" +  $("#food_foodId_edit").val() + "/update",
			    onSubmit: function(){
					if($("#foodEditForm").form("validate"))  {
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
			$("#foodEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
