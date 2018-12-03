{include file='admin-head.tpl'}

<div class="layui-body admin-detect">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<div class="layui-row">
		<h1 class="site-h1">审计规则</h1>
		<div class="layui-layout-right sub">
			<a class="layui-btn" href="/admin/detect/create"><i class="icon ptfont pticon-addnewbuttonpl"></i> 添加审计规则</a>
		</div>
	</div>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">规则列表</div>
				<div class="layui-card-body">
					显示表项: {include file='table/checkbox.tpl'}
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
require(['jquery','datatables.net'],function($,datatables){

	$(document).ready(function(){

		{include file='table/js_2.tpl'}
		
		delete_modal_show = function(id){
			deleteid=id;
			layer.confirm('确定要删除？', {
			  btn: ['确定','取消']
			}, function(){
			  delete_id()
			}, function(){
			  layer.close()
			});
		}

		delete_id = function(){
			$.ajax({
				type:"DELETE",
				url:"/admin/detect",
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
					layer.msg(data.msg+"  发生错误了。");
				}
			});
		}		

		$("#delete_input").click(function(){
			delete_id();
		});

	})
})
</script>