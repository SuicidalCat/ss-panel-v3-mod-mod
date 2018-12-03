{include file='admin-head.tpl'}

<div class="layui-body admin-code">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<div class="layui-row">
		<h1 class="site-h1">充值卡</h1>
		<div class="layui-layout-right sub">
			<a class="layui-btn" href="/admin/code/create"><i class="icon ptfont pticon-addnewbuttonpl"></i> 添加充值卡</a>
		</div>
	</div>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">使用记录</div>
				<div class="layui-card-body">
					显示表项:{include file='table/checkbox.tpl'}
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
	{include file='table/js_2.tpl'}
})
</script>