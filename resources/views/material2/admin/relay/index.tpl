{include file='admin-head.tpl'}

<div class="layui-body admin-relay">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<div class="layui-row">
		<h1 class="site-h1">中转规则</h1>
		<div class="layui-layout-right sub">
			<a class="layui-btn" href="/admin/relay/create"><i class="icon ptfont pticon-addnewbuttonpl"></i> 添加中转规则</a>
		</div>
	</div>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					<form class="layui-form layui-form-pane" id="block_form">
					  <div class="layui-form-item">
					    <label class="layui-form-label">输入用户ID</label>
					    <div class="layui-input-inline">
					      <input type="text" id="search" class="layui-input" required>
					    </div>
					    <div class="layui-input-mid">
					    	<button class="layui-btn" id="search_button" type="submit"><i class="icon ptfont pticon-magnifiersearchd"></i> 搜索</button>
					    </div>
					  </div>
					</form>
				</div>
			</div>
		</div>

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">中转规则列表</div>
				<div class="layui-card-body">
					显示表项:
	                {include file='table/checkbox.tpl'}
	                <div class="table-over">
	                {include file='table/table.tpl'}
	            	</div>
				</div>
			</div>
		</div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='admin-foot.tpl'}

<script>
require(['domReady','jquery','datatables.net'],function(domReady,$,datatables){
	domReady(function(){
		delete_modal_show = function(id){
			deleteid=id;
			layer.confirm('确定要删除？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
			  delete_id()
			}, function(){
			  layer.close()
			});
		}

		{include file='table/js_2.tpl'}

		delete_id = function(){
			$.ajax({
				type:"DELETE",
				url:"/admin/relay",
				dataType:"json",
				data:{
					id: deleteid
				},
				success:function(data){
					if(data.ret){
						layer.msg(data.msg);
						table_1.row('#row_1_' + deleteid).remove().draw();
					}else{
						layer.msg(data.msg);
					}
				},
				error:function(jqXHR){
					layer.msg(data.msg+"  发生错误了");
				}
			});
		}

		$("#delete_input").click(function(){
			delete_id();
		});

		search = function(){
			window.location="/admin/relay/path_search/"+$("#search").val();
		}

		$("#search_button").click(function(){
			if($("#search").val()!="")
			{
				search();
			}
		});
		
	})
})
</script>