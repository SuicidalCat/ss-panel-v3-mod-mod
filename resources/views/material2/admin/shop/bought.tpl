{include file='admin-head.tpl'}

<div class="layui-body admin-shop admin-shop-bought">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">购买记录</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">购买记录列表</div>
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

	delete_modal_show=function(id) {
		deleteid=id;
		layer.confirm('确定中止？', {
          btn: ['确定','取消'] //按钮
        }, function(){
          delete_id()
        }, function(){
          layer.close()
        });
	}

	domReady(function(){		
		{include file='table/js_2.tpl'}

		delete_id=function(){
			$.ajax({
				type:"DELETE",
				url:"/admin/bought",
				dataType:"json",
				data:{
					id: deleteid
				},
				success:function(data){
					if(data.ret){
						{literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
						$("#row_delete_"+deleteid).attr("disabled","true");
					}else{
						layer.msg(data.msg);
					}
				},
				error:function(jqXHR){
					layer.msg(data.msg+"发生错误了。");
				}
			});
		}
		$("#delete_input").click(function(){
			delete_id();
		});

	})
})
</script>