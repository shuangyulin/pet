$(function () {
	$("#adopt_petObj_petId").combobox({
	    url:'Pet/listAll',
	    valueField: "petId",
	    textField: "petName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#adopt_petObj_petId").combobox("getData"); 
            if (data.length > 0) {
                $("#adopt_petObj_petId").combobox("select", data[0].petId);
            }
        }
	});
	$("#adopt_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#adopt_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#adopt_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#adopt_addTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	$("#adopt_shenHe").validatebox({
		required : true, 
		missingMessage : '请输入审核状态',
	});

	//单击添加按钮
	$("#adoptAddButton").click(function () {
		//验证表单 
		if(!$("#adoptAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#adoptAddForm").form({
			    url:"Adopt/add",
			    onSubmit: function(){
					if($("#adoptAddForm").form("validate"))  { 
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
                        $("#adoptAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#adoptAddForm").submit();
		}
	});

	//单击清空按钮
	$("#adoptClearButton").click(function () { 
		$("#adoptAddForm").form("clear"); 
	});
});
