var petClass_manage_tool = null; 
$(function () { 
	initPetClassManageTool(); //建立PetClass管理对象
	petClass_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#petClass_manage").datagrid({
		url : 'PetClass/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "petClassId",
		sortOrder : "desc",
		toolbar : "#petClass_manage_tool",
		columns : [[
			{
				field : "petClassId",
				title : "宠物类别id",
				width : 70,
			},
			{
				field : "petClassName",
				title : "宠物类别名称",
				width : 140,
			},
		]],
	});

	$("#petClassEditDiv").dialog({
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
				if ($("#petClassEditForm").form("validate")) {
					//验证表单 
					if(!$("#petClassEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#petClassEditForm").form({
						    url:"PetClass/" + $("#petClass_petClassId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#petClassEditDiv").dialog("close");
			                        petClass_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#petClassEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#petClassEditDiv").dialog("close");
				$("#petClassEditForm").form("reset"); 
			},
		}],
	});
});

function initPetClassManageTool() {
	petClass_manage_tool = {
		init: function() {
		},
		reload : function () {
			$("#petClass_manage").datagrid("reload");
		},
		redo : function () {
			$("#petClass_manage").datagrid("unselectAll");
		},
		search: function() {
			$("#petClass_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#petClassQueryForm").form({
			    url:"PetClass/OutToExcel",
			});
			//提交表单
			$("#petClassQueryForm").submit();
		},
		remove : function () {
			var rows = $("#petClass_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var petClassIds = [];
						for (var i = 0; i < rows.length; i ++) {
							petClassIds.push(rows[i].petClassId);
						}
						$.ajax({
							type : "POST",
							url : "PetClass/deletes",
							data : {
								petClassIds : petClassIds.join(","),
							},
							beforeSend : function () {
								$("#petClass_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#petClass_manage").datagrid("loaded");
									$("#petClass_manage").datagrid("load");
									$("#petClass_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#petClass_manage").datagrid("loaded");
									$("#petClass_manage").datagrid("load");
									$("#petClass_manage").datagrid("unselectAll");
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
			var rows = $("#petClass_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "PetClass/" + rows[0].petClassId +  "/update",
					type : "get",
					data : {
						//petClassId : rows[0].petClassId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (petClass, response, status) {
						$.messager.progress("close");
						if (petClass) { 
							$("#petClassEditDiv").dialog("open");
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
