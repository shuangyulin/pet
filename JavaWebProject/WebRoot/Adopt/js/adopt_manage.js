var adopt_manage_tool = null; 
$(function () { 
	initAdoptManageTool(); //建立Adopt管理对象
	adopt_manage_tool.init(); //如果需要通过下拉框查询，首先初始化下拉框的值
	$("#adopt_manage").datagrid({
		url : 'Adopt/list',
		fit : true,
		fitColumns : true,
		striped : true,
		rownumbers : true,
		border : false,
		pagination : true,
		pageSize : 5,
		pageList : [5, 10, 15, 20, 25],
		pageNumber : 1,
		sortName : "adoptId",
		sortOrder : "desc",
		toolbar : "#adopt_manage_tool",
		columns : [[
			{
				field : "adoptId",
				title : "领养id",
				width : 70,
			},
			{
				field : "petObj",
				title : "被领养宠物",
				width : 140,
			},
			{
				field : "userObj",
				title : "领养人",
				width : 140,
			},
			{
				field : "addTime",
				title : "领养申请时间",
				width : 140,
			},
			{
				field : "shenHe",
				title : "审核状态",
				width : 140,
			},
		]],
	});

	$("#adoptEditDiv").dialog({
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
				if ($("#adoptEditForm").form("validate")) {
					//验证表单 
					if(!$("#adoptEditForm").form("validate")) {
						$.messager.alert("错误提示","你输入的信息还有错误！","warning");
					} else {
						$("#adoptEditForm").form({
						    url:"Adopt/" + $("#adopt_adoptId_edit").val() + "/update",
						    onSubmit: function(){
								if($("#adoptEditForm").form("validate"))  {
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
			                        $("#adoptEditDiv").dialog("close");
			                        adopt_manage_tool.reload();
			                    }else{
			                        $.messager.alert("消息",obj.message);
			                    } 
						    }
						});
						//提交表单
						$("#adoptEditForm").submit();
					}
				}
			},
		},{
			text : "取消",
			iconCls : "icon-redo",
			handler : function () {
				$("#adoptEditDiv").dialog("close");
				$("#adoptEditForm").form("reset"); 
			},
		}],
	});
});

function initAdoptManageTool() {
	adopt_manage_tool = {
		init: function() {
			$.ajax({
				url : "Pet/listAll",
				type : "post",
				success : function (data, response, status) {
					$("#petObj_petId_query").combobox({ 
					    valueField:"petId",
					    textField:"petName",
					    panelHeight: "200px",
				        editable: false, //不允许手动输入 
					});
					data.splice(0,0,{petId:0,petName:"不限制"});
					$("#petObj_petId_query").combobox("loadData",data); 
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
			$("#adopt_manage").datagrid("reload");
		},
		redo : function () {
			$("#adopt_manage").datagrid("unselectAll");
		},
		search: function() {
			var queryParams = $("#adopt_manage").datagrid("options").queryParams;
			queryParams["petObj.petId"] = $("#petObj_petId_query").combobox("getValue");
			queryParams["userObj.user_name"] = $("#userObj_user_name_query").combobox("getValue");
			queryParams["addTime"] = $("#addTime").datebox("getValue"); 
			queryParams["shenHe"] = $("#shenHe").val();
			$("#adopt_manage").datagrid("options").queryParams=queryParams; 
			$("#adopt_manage").datagrid("load");
		},
		exportExcel: function() {
			$("#adoptQueryForm").form({
			    url:"Adopt/OutToExcel",
			});
			//提交表单
			$("#adoptQueryForm").submit();
		},
		remove : function () {
			var rows = $("#adopt_manage").datagrid("getSelections");
			if (rows.length > 0) {
				$.messager.confirm("确定操作", "您正在要删除所选的记录吗？", function (flag) {
					if (flag) {
						var adoptIds = [];
						for (var i = 0; i < rows.length; i ++) {
							adoptIds.push(rows[i].adoptId);
						}
						$.ajax({
							type : "POST",
							url : "Adopt/deletes",
							data : {
								adoptIds : adoptIds.join(","),
							},
							beforeSend : function () {
								$("#adopt_manage").datagrid("loading");
							},
							success : function (data) {
								if (data.success) {
									$("#adopt_manage").datagrid("loaded");
									$("#adopt_manage").datagrid("load");
									$("#adopt_manage").datagrid("unselectAll");
									$.messager.show({
										title : "提示",
										msg : data.message
									});
								} else {
									$("#adopt_manage").datagrid("loaded");
									$("#adopt_manage").datagrid("load");
									$("#adopt_manage").datagrid("unselectAll");
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
			var rows = $("#adopt_manage").datagrid("getSelections");
			if (rows.length > 1) {
				$.messager.alert("警告操作！", "编辑记录只能选定一条数据！", "warning");
			} else if (rows.length == 1) {
				$.ajax({
					url : "Adopt/" + rows[0].adoptId +  "/update",
					type : "get",
					data : {
						//adoptId : rows[0].adoptId,
					},
					beforeSend : function () {
						$.messager.progress({
							text : "正在获取中...",
						});
					},
					success : function (adopt, response, status) {
						$.messager.progress("close");
						if (adopt) { 
							$("#adoptEditDiv").dialog("open");
							$("#adopt_adoptId_edit").val(adopt.adoptId);
							$("#adopt_adoptId_edit").validatebox({
								required : true,
								missingMessage : "请输入领养id",
								editable: false
							});
							$("#adopt_petObj_petId_edit").combobox({
								url:"Pet/listAll",
							    valueField:"petId",
							    textField:"petName",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#adopt_petObj_petId_edit").combobox("select", adopt.petObjPri);
									//var data = $("#adopt_petObj_petId_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#adopt_petObj_petId_edit").combobox("select", data[0].petId);
						            //}
								}
							});
							$("#adopt_userObj_user_name_edit").combobox({
								url:"UserInfo/listAll",
							    valueField:"user_name",
							    textField:"name",
							    panelHeight: "auto",
						        editable: false, //不允许手动输入 
						        onLoadSuccess: function () { //数据加载完毕事件
									$("#adopt_userObj_user_name_edit").combobox("select", adopt.userObjPri);
									//var data = $("#adopt_userObj_user_name_edit").combobox("getData"); 
						            //if (data.length > 0) {
						                //$("#adopt_userObj_user_name_edit").combobox("select", data[0].user_name);
						            //}
								}
							});
							$("#adopt_addTime_edit").datetimebox({
								value: adopt.addTime,
							    required: true,
							    showSeconds: true,
							});
							$("#adopt_shenHe_edit").val(adopt.shenHe);
							$("#adopt_shenHe_edit").validatebox({
								required : true,
								missingMessage : "请输入审核状态",
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
