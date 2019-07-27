$(function () {
	//实例化编辑器
	//建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
	UE.delEditor('pet_petDesc');
	var pet_petDesc_editor = UE.getEditor('pet_petDesc'); //宠物介绍编辑框
	$("#pet_petClassObj_petClassId").combobox({
	    url:'PetClass/listAll',
	    valueField: "petClassId",
	    textField: "petClassName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#pet_petClassObj_petClassId").combobox("getData"); 
            if (data.length > 0) {
                $("#pet_petClassObj_petClassId").combobox("select", data[0].petClassId);
            }
        }
	});
	$("#pet_petName").validatebox({
		required : true, 
		missingMessage : '请输入宠物名称',
	});

	$("#pet_petRequest").validatebox({
		required : true, 
		missingMessage : '请输入领养要求',
	});

	$("#pet_petState").validatebox({
		required : true, 
		missingMessage : '请输入领养状态',
	});

	$("#pet_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#petAddButton").click(function () {
		if(pet_petDesc_editor.getContent() == "") {
			alert("请输入宠物介绍");
			return;
		}
		//验证表单 
		if(!$("#petAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#petAddForm").form({
			    url:"Pet/add",
			    onSubmit: function(){
					if($("#petAddForm").form("validate"))  { 
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
                        $("#petAddForm").form("clear");
                        pet_petDesc_editor.setContent("");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#petAddForm").submit();
		}
	});

	//单击清空按钮
	$("#petClearButton").click(function () { 
		$("#petAddForm").form("clear"); 
	});
});
