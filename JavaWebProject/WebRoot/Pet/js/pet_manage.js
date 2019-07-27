var pet_manage_tool = null; 
$(function () { 
	initPetManageTool(); //建立Pet管理对象
	pet_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#pet_manage").datagrid({
		url : 'Pet/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "petId",
		sortOrder : "desc",
		toolbar : "#pet_manage_tool",
		columns : [[
			{
				field : "petId",
				title : "宠物id",
				width : 70,
			},
			{
				field : "petClassObj",
				title : "宠物类别",
				width : 140,
			},
			{
				field : "petName",
				title : "宠物名称",
				width : 140,
			},
			{
				field : "petPhoto",
				title : "宠物照片",
				width : "70px",
				height: "65px",
				formatter: function(val,row) {
					return "<img src='" + val + "' width='65px' height='55px' />";
				}
 			},
			{
				field : "petRequest",
				title : "领养要求",
				width : 140,
			},
			{
				field : "petState",
				title : "领养状态",
				width : 140,
			},
			{
				field : "addTime",
				title : "登记时间",
				width : 140,
			},
		]],
	});

	$("#petEditDiv").dialog({
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
				if ($("#petEditForm").form("validate")) {
					//验证表单 
					if(!$("#petEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#petEditForm").form({
						    url:"Pet/" + $("#pet_petId_edit").val() + "/update",
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
						    	console.log(data);
			                	var obj = jQuery.parseJSON(data);
			                    if(obj.success){
			                        $.messager.alert("消息","信息修改成功！");
			                        $("#petEditDiv").dialog("close");
			                        pet_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#petEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#petEditDiv").dialog("close");
				$("#petEditForm").form("reset"); 
			},
		}],
	});
});

function initPetManageTool() {
	pet_manage_tool = {
		init: function() {
			$.ajax({
				url : "PetClass/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#petClassObj_petClassId_query").combobox({ 
					    valueField:"petClassId",
					    textField:"petClassName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{petClassId:0,petClassName:"不限制"});
					$("#petClassObj_petClassId_query").combobox("loadData",data); 
				}
			});
		},
		reload : function () {
			$("#pet_manage").datagrid("reload");
		},
		redo : function () {
			$("#pet_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#pet_manage").datagrid("options").queryParams;
			queryParams["petClassObj.petClassId"] = $("#petClassObj_petClassId_query").combobox("getValue");
			queryParams["petName"] = $("#petName").val();
			queryParams["petState"] = $("#petState").val();
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			$("#pet_manage").datagrid("options").queryParams=queryParams; 
			$("#pet_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#petQueryForm").form({
			    url:"Pet/OutToExcel",
			});
			//提交表单
			$("#petQueryForm").submit();
		},
		remove : function () {
			var rows = $("#pet_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var petIds = [];
						for (var i = 0; i < rows.length; i ++) {
							petIds.push(rows[i].petId);
						}
						$.ajax({
							type : "POST",
							url : "Pet/deletes",
							data : {
								petIds : petIds.join(","),
							},
							beforeSend : function () {
								$("#pet_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#pet_manage").datagrid("loaded");
									$("#pet_manage").datagrid("load");
									$("#pet_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#pet_manage").datagrid("loaded");
									$("#pet_manage").datagrid("load");
									$("#pet_manage").datagrid("unselectAll");
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
			var rows = $("#pet_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Pet/" + rows[0].petId +  "/update",
					type : "get",
					data : {
						//petId : rows[0].petId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (pet, response, status) {
						$.messager.progress("close");
						if (pet) { 
							$("#petEditDiv").dialog("open");
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
							pet_petDesc_editor.setContent(pet.petDesc, false);
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
						}
					}
				});
			} else if (rows.length == 0) {
				$.messager.alert("警告操作！", "编辑记录至少选定一条数据！", "warning");
			}
		},
	};
}
