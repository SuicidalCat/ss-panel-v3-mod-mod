{include file='admin-head.tpl'}

<div class="layui-body admin-ip admin-ip-alive">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">在线IP</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
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
require(['domReady','jquery','datatables.net'],function(domReady,$,datatables){
	domReady(function(){
	 	{include file='table/js_2.tpl'}
	});
})
</script>