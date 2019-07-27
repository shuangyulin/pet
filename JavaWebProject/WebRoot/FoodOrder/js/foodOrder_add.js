$(function () {
	$("#foodOrder_foodObj_foodId").combobox({
	    url:'Food/listAll',
	    valueField: "foodId",
	    textField: "foodName",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#foodOrder_foodObj_foodId").combobox("getData"); 
            if (data.length > 0) {
                $("#foodOrder_foodObj_foodId").combobox("select", data[0].foodId);
            }
        }
	});
	$("#foodOrder_userObj_user_name").combobox({
	    url:'UserInfo/listAll',
	    valueField: "user_name",
	    textField: "name",
	    panelHeight: "auto",
        editable: false, //不允许手动输入
        required : true,
        onLoadSuccess: function () { //数据加载完毕事件
            var data = $("#foodOrder_userObj_user_name").combobox("getData"); 
            if (data.length > 0) {
                $("#foodOrder_userObj_user_name").combobox("select", data[0].user_name);
            }
        }
	});
	$("#foodOrder_orderNumber").validatebox({
		required : true,
		validType : "integer",
		missingMessage : '请输入预订数量',
		invalidMessage : '预订数量输入不对',
	});

	$("#foodOrder_orderState").validatebox({
		required : true, 
		missingMessage : '请输入订单状态',
	});

	$("#foodOrder_orderTime").datetimebox({
	    required : true, 
	    showSeconds: true,
	    editable: false
	});

	//单击添加按钮
	$("#foodOrderAddButton").click(function () {
		//验证表单 
		if(!$("#foodOrderAddForm").form("validate")) {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		} else {
			$("#foodOrderAddForm").form({
			    url:"FoodOrder/add",
			    onSubmit: function(){
					if($("#foodOrderAddForm").form("validate"))  { 
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
                        $("#foodOrderAddForm").form("clear");
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    }
			    }
			});
			//提交表单
			$("#foodOrderAddForm").submit();
		}
	});

	//单击清空按钮
	$("#foodOrderClearButton").click(function () { 
		$("#foodOrderAddForm").form("clear"); 
	});
});
