<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel list</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/layui/css/layui.css">
</head>
<body>
<div style="margin-top: 20px;margin-left: 20px">
	<!-- 搜索的form -->
	<form class="layui-form layui-form-pane">
		<!-- 一排3个 -->
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">Hotel Name</label>
				<div class="layui-input-inline">
					<input id="name" class="layui-input" />
				</div>
			</div>
		</div>
		<!-- 一排3个 -->
		<div class="layui-form-item">
			<div class="layui-inline">
				<div class="layui-input-inline" style="width: 90px;">
					<button type="button" class="layui-btn" id="searchBtn"><i class="layui-icon layui-icon-search"></i>Search</button>
				</div>
			</div>
		</div>
	</form>
	<hr class="layui-bg-green">
	<table id="dataTable" lay-filter="dataTableFilter"></table>
</div>
<!-- 头工具栏 -->
<script type="text/html" id="headerBtns">
	<div class="layui-btn-group">
		<button class="layui-btn layui-btn-sm" lay-event="add"><i class="layui-icon layui-icon-add-1"></i>Add</button>
	</div>
</script>
<!-- 行工具栏 -->
<script type="text/html" id="rowBtns">
	<button class="layui-btn layui-btn-sm layui-btn-danger" lay-event="del"><i class="layui-icon layui-icon-delete"></i>Delete</button>		
</script>

<!-- ADD -->

<script type="text/html" id="addTpl">
<div style="width: 400px;margin: auto;margin-top: 20px;">
<!-- form 容器已定义好 -->
<form class="layui-form layui-form-pane" lay-filter="formFilter">
	
	<div class="layui-form-item">
	<label class="layui-form-label" >Hotel Name</label>
	<div class="layui-inline">
	<select name="name">
 	 	<option value=""Hotel name</option>
  		<option value="aaa">aaa</option>
 	 	<option value="bbb">bbb</option>
  		<option value="ccc">ccc</option>
	</select>
	</div>	
	</div>
	

	<div class="layui-form-item">
		<label class="layui-form-label">Price</label>
		<div class="layui-input-inline">
			<input name="price" class="layui-input"  />
		</div>
	</div>
	

	<div class="layui-form-item" >
		<label class="layui-form-label" >Room</label>
		<div class="layui-input-block">
			<input type="radio" name="type" value="1" title="Standard room"/><br>
			<input type="radio" name="type" value="2" title="Superior room"/><br>
			<input type="radio" name="type" value="3" title="President suite"/>
		</div>
	</div>


	<div class="layui-form-item">
		<label class="layui-form-label">Information:</label>
			<div class="layui-input-block">
				<textarea name="info" id="info" style="width:250px"></textarea>
			</div>
	</div>


	<button type="button" id="submitBtn" lay-submit lay-filter="submitBtnFilter" class="display:none"></button>
</form>
</div>

</script>
<script src="${pageContext.request.contextPath}/resources/layui/layui.js"></script>
<script type="text/javascript">
	layui.use(['form','jquery','layer','laydate','table'],function(){
		var form = layui.form;
		var $ = layui.jquery;
		var layer = layui.layer;
		var table = layui.table;

		//渲染table数据表格
		var t = table.render({
			id:"dataTableId",
			elem:"#dataTable",
			url:"hotel.do?service=list",//数据地址
			page:true,//开启分页
			toolbar:"#headerBtns",//
			height:480,
			parseData:function(rs){//数据解析
				console.log("返回的数据是:");
				console.log(rs);
				if(rs.code == 200){
					return {
						"code":rs.code,
						"msg":rs.msg,
						"count":rs.data.count,
						"data":rs.data.data
					}
				}
			},
			response:{//重新定义响应码
				"statusCode":200
			},
			// table fields
			cols:[[
				{type:'checkbox'},
				{field:'roomId',title:'roomId',hide:true},
				{field:'id',title:'Hotel ID',width:'85'},
				
				{field:'name',title:'Hotel Name',width:'110'},
				
				{field:'type',title:'Room type',width:'100',templet:function(d){
					if(d.type == 1){
						return "<b style='color:green'>Standard room</b>";
					}else if(d.type == 2){
						return "<b style='color:red'>Superior room</b>";
					}
					else if(d.type==3){
						return "<b style='color:red'>President suite</b>";
					}
				}},
				{field:'price',title:'Price',width:'110'},
				{field:'address',title:'Address',width:'110'},
				{field:'mobile',title:'Tel',width:'110'},
				{title:'Operation',toolbar:'#rowBtns',fixed:'right',width:'270'}
			]]
		});
		//搜索按钮事件
		$("#searchBtn").click(function(){
			var name = $("#name").val();
			//进行表格数据重载
			t.reload({
				where:{
					name:name,
				},
				page:1
			});
		});
		//=====头监听事件=====================================================================	
		table.on('toolbar(dataTableFilter)',function(d){
			//获取具体的事件类型
			var event = d.event;
			if(event == "add"){
				//调用具体的添加方法
				add();
			}
		});
		//-----具体添加方法------------
		function add(){
			layer.open({
				type:1,//html
				title:'Add hotel',
				content:$("#addTpl").html(),//弹层内容
				area:['400px','500px'],//宽高
				btn:['Submit','Cancel'],
				btnAlign:'c',//按钮居中
				btn1:function(index,layero){//点击确认时触发的方法
					//点击确认时 提交form表单 
					$("#submitBtn").click();//使用js点击隐藏的提交按钮
				},
				success:function(layero,index){//当弹出层  弹出时 调用的函数
					form.render();//重新渲染 表单元素
					//为表单绑定提交监听事件
					form.on("submit(submitBtnFilter)",function(d){
						//获取表单数据
						var param = d.field;
						//使用ajax提交数据
						$.post("hotel.do?service=add",param,function(rs){
							//校验业务码
							if(rs.code != 200){
								//显示异常信息
								layer.msg(rs.msg);
								return false;
							}
							//关闭弹出层
							layer.close(index);
							//重载数据列表
							$("#searchBtn").click();
						});
						//阻止表单的默认提交行为
						return false;
					});
				}
			});
		}
		//==行监听事件=============================================	
		table.on("tool(dataTableFilter)",function(d){
			var event = d.event;
			var data = d.data;
			if(event == "del"){
				del(data);
			}
		});	
		//--Delete-----------------------------
		function del(data){
			//使用二次确认
			layer.confirm("Confirm to delete",function(index){
				//将需要重置的用户ID 传给后台
				$.get("hotel.do?service=delete",{id:data.roomId},function(rs){
					//校验业务码
					if(rs.code != 200){
						//显示异常信息
						layer.msg(rs.msg);
						return false;
					}
					layer.msg("重置成功");
					//关闭弹出层
					layer.close(index);
					//重载数据列表
					$("#searchBtn").click();
				});
			});
		}
	});
</script>
</body>
</html>
