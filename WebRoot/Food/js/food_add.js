$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('food_foodDesc');
	var food_foodDesc_editor = UE.getEditor('food_foodDesc'); //宠粮介绍编辑框
	$("#food_foodName").validatebox({
		required : true, 
		missingMessage : '请输入宠粮名称',
	});

	$("#food_foodNum").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入库存数量',
		invalidMessage : '库存数量输入不对',
	});

	$("#food_addDate").datebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#foodAddButton").click(function () {
		if(food_foodDesc_editor.getContent() == "") {
			alert("请输入宠粮介绍");
			return;
		}
		//验证表单 
		if(!$("#foodAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#foodAddForm").form({
			    url:"Food/add",
			    onSubmit: function(){
					if($("#foodAddForm").form("validate"))  { 
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
                    //此处data={"Success":true}是字符串
                	var obj = jQuery.parseJSON(data); 
                    if(obj.success){ 
                        $.messager.alert("消息","保存成功！");
                        $(".messager-window").css("z-index",10000);
                        $("#foodAddForm").form("clear");
                        food_foodDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#foodAddForm").submit();
		}
	});

	//单击清空按钮
	$("#foodClearButton").click(function () { 
		$("#foodAddForm").form("clear"); 
	});
});
