var food_manage_tool = null; 
$(function () { 
	initFoodManageTool(); //建立Food管理对象
	food_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#food_manage").datagrid({
		url : 'Food/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "foodId",
		sortOrder : "desc",
		toolbar : "#food_manage_tool",
		columns : [[
			{
				field : "foodId",
				title : "宠粮id",
				width : 70,
			},
			{
				field : "foodName",
				title : "宠粮名称",
				width : 140,
			},
			{
				field : "foodPhoto",
				title : "宠粮照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "foodNum",
				title : "库存数量",
				width : 70,
			},
			{
				field : "addDate",
				title : "上架日期",
				width : 140,
			},
		]],
	});

	$("#foodEditDiv").dialog({
		title : "修改管理",
		top: "10px",
		width : 1000,
		height : 600,
		modal : true,
		closed : true,
		iconCls : "icon-edit-new",
		buttons : [{
			text : "提交",
			iconCls : "icon-edit-new",
			handler : function () {
				if ($("#foodEditForm").form("validate")) {
					//验证表单 
					if(!$("#foodEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#foodEditForm").form({
						    url:"Food/" + $("#food_foodId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#foodEditDiv").dialog("close");
			                        food_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#foodEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#foodEditDiv").dialog("close");
				$("#foodEditForm").form("reset"); 
			},
		}],
	});
});

function initFoodManageTool() {
	food_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#food_manage").datagrid("reload");
		},
		redo : function () {
			$("#food_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#food_manage").datagrid("options").queryParams;
			queryParams["foodName"] = $("#foodName").val();
			queryParams["addDate"] = $("#addDate").datebox("getValue"); 
			$("#food_manage").datagrid("options").queryParams=queryParams; 
			$("#food_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#foodQueryForm").form({
			    url:"Food/OutToExcel",
			});
			//提交表单
			$("#foodQueryForm").submit();
		},
		remove : function () {
			var rows = $("#food_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var foodIds = [];
						for (var i = 0; i < rows.length; i ++) {
							foodIds.push(rows[i].foodId);
						}
						$.ajax({
							type : "POST",
							url : "Food/deletes",
							data : {
								foodIds : foodIds.join(","),
							},
							beforeSend : function () {
								$("#food_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#food_manage").datagrid("loaded");
									$("#food_manage").datagrid("load");
									$("#food_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#food_manage").datagrid("loaded");
									$("#food_manage").datagrid("load");
									$("#food_manage").datagrid("unselectAll");
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
			var rows = $("#food_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Food/" + rows[0].foodId +  "/update",
					type : "get",
					data : {
						//foodId : rows[0].foodId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (food, response, status) {
						$.messager.progress("close");
						if (food) { 
							$("#foodEditDiv").dialog("open");
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
							food_foodDesc_editor.setContent(food.foodDesc, false);
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
