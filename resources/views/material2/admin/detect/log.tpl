{include file='admin-head.tpl'}

<div class="layui-body admin-detect admin-detect-log">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">审计记录</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">所有审计记录</div>
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
require(['jquery','datatables.net'],function($,datatables){
	$(document).ready(function(){
		{include file='table/js_2.tpl'}
	});
})
</script>