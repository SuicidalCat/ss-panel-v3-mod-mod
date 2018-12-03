{include file='theme-head.tpl'}
<body>

<div id="theme-page" class="layui-container theme-code">

	<!--title-->
	<h1 class="site-h1">邀请码</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="table-over">
		     <table class="layui-table">
				<thead>
				<tr>
					<th>ID</th>
					<th>邀请码 (直接戳邀请码进行注册)</th>
					<th>状态</th>
				</tr>
				</thead>
				<tbody>
				{foreach $codes as $code}
				<tr>
					<td>{$code->id}</td>
					<td><a href="/auth/register?code={$code->code}">{$code->code}</a></td>
					<td>可用</td>
				</tr>
				{/foreach}
				</tbody>
			</table>
			</div>
		</div>		

    </div>
	<!--content:end-->

</div>

{include file='theme-foot.tpl'}