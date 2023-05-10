var foodOrder_manage_tool = null; 
$(function () { 
	initFoodOrderManageTool(); //建立FoodOrder管理对象
	foodOrder_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#foodOrder_manage").datagrid({
		url : 'FoodOrder/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "orderId",
		sortOrder : "desc",
		toolbar : "#foodOrder_manage_tool",
		columns : [[
			{
				field : "orderId",
				title : "订单id",
				width : 70,
			},
			{
				field : "foodObj",
				title : "宠粮名称",
				width : 140,
			},
			{
				field : "userObj",
				title : "预订用户",
				width : 140,
			},
			{
				field : "orderNumber",
				title : "预订数量",
				width : 70,
			},
			{
				field : "orderState",
				title : "订单状态",
				width : 140,
			},
			{
				field : "orderTime",
				title : "预订时间",
				width : 140,
			},
		]],
	});

	$("#foodOrderEditDiv").dialog({
		title : "修改管理",
		top: "50px",
		width : 700,
		height : 515,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#foodOrderEditForm").form("validate")) {
					//验证表单 
					if(!$("#foodOrderEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#foodOrderEditForm").form({
						    url:"FoodOrder/" + $("#foodOrder_orderId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#foodOrderEditForm").form("validate"))  {
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#foodOrderEditDiv").dialog("close");
			                        foodOrder_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#foodOrderEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#foodOrderEditDiv").dialog("close");
				$("#foodOrderEditForm").form("reset"); 
			},
		}],
	});
});

function initFoodOrderManageTool() {
	foodOrder_manage_tool = {
		init: function() {
			$.ajax({
				url : "Food/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#foodObj_foodId_query").combobox({ 
					    valueField:"foodId",
					    textField:"foodName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{foodId:0,foodName:"不限制"});
					$("#foodObj_foodId_query").combobox("loadData",data); 
				}
			});
			$.ajax({
				url : "UserInfo/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#userObj_user_name_query").combobox({ 
					    valueField:"user_name",
					    textField:"name",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{user_name:"",name:"不限制"});
					$("#userObj_user_name_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#foodOrder_manage").datagrid("reload");
		},
		redo : function () {
			$("#foodOrder_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#foodOrder_manage").datagrid("options").queryParams;
			queryParams["foodObj.foodId"] = $("#foodObj_foodId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["orderState"] = $("#orderState").val();
			queryParams["orderTime"] = $("#orderTime").datebox("getValue"); 
			$("#foodOrder_manage").datagrid("options").queryParams=queryParams; 
			$("#foodOrder_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#foodOrderQueryForm").form({
			    url:"FoodOrder/OutToExcel",
			});
			//提交表单
			$("#foodOrderQueryForm").submit();
		},
		remove : function () {
			var rows = $("#foodOrder_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var orderIds = [];
						for (var i = 0; i < rows.length; i ++) {
							orderIds.push(rows[i].orderId);
						}
						$.ajax({
							type : "POST",
							url : "FoodOrder/deletes",
							data : {
								orderIds : orderIds.join(","),
							},
							beforeSend : function () {
								$("#foodOrder_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#foodOrder_manage").datagrid("loaded");
									$("#foodOrder_manage").datagrid("load");
									$("#foodOrder_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#foodOrder_manage").datagrid("loaded");
									$("#foodOrder_manage").datagrid("load");
									$("#foodOrder_manage").datagrid("unselectAll");
									$.messager.alert("消息",data.message);
								}
							},
						});
					}
				});
			} else {
				$.messager.alert("提示", "请选择要删除的记录！", "info");
			}
		},
		edit : function () {
			var rows = $("#foodOrder_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "FoodOrder/" + rows[0].orderId +  "/update",
					type : "get",
					data : {
						//orderId : rows[0].orderId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (foodOrder, response, status) {
						$.messager.progress("close");
						if (foodOrder) { 
							$("#foodOrderEditDiv").dialog("open");
							$("#foodOrder_orderId_edit").val(foodOrder.orderId);
							$("#foodOrder_orderId_edit").validatebox({
								required : true,
								missingMessage : "请输入订单id",
								editable: false
							});
							$("#foodOrder_foodObj_foodId_edit").combobox({
								url:"Food/listAll",
							    valueField:"foodId",
							    textField:"foodName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#foodOrder_foodObj_foodId_edit").combobox("select", foodOrder.foodObjPri);
									//var data = $("#foodOrder_foodObj_foodId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#foodOrder_foodObj_foodId_edit").combobox("select", data[0].foodId);
						            //}
								}
							});
							$("#foodOrder_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#foodOrder_userObj_user_name_edit").combobox("select", foodOrder.userObjPri);
									//var data = $("#foodOrder_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#foodOrder_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#foodOrder_orderNumber_edit").val(foodOrder.orderNumber);
							$("#foodOrder_orderNumber_edit").validatebox({
								required : true,
								validType : "integer",
								missingMessage : "请输入预订数量",
								invalidMessage : "预订数量输入不对",
							});
							$("#foodOrder_orderState_edit").val(foodOrder.orderState);
							$("#foodOrder_orderState_edit").validatebox({
								required : true,
								missingMessage : "请输入订单状态",
							});
							$("#foodOrder_orderTime_edit").datetimebox({
								value: foodOrder.orderTime,
							    required: true,
							    showSeconds: true,
							});
						} else {
							$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
