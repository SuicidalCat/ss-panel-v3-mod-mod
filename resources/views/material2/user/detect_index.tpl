{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">审计<span>注意：以下规则仅用于管理(禁止)不当行为，不会记录您的隐私访问。</span></h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
	        <div class="layui-card-body">

	        	<div class="layui-tab layui-tab-brief">
				  <ul class="layui-tab-title">
				    <li><a href="/user/detect/log">审计记录</a></li>
				    <li class="layui-this">审计规则</li>
				  </ul>
				  <div class="layui-tab-content">
				  	
				  	<div class="table-over">
						{$rules->render()}
						<table class="layui-table">
							<thead>
						    <tr>
						        <th>ID</th>
						        <th>名称</th>
						        <th>描述</th>
							<th>正则表达式</th>
							<th>类型</th>							
						    </tr>
						    </thead>
						    {foreach $rules as $rule}
						        <tr>
								<td>#{$rule->id}</td>
								<td>{$rule->name}</td>
								<td>{$rule->text}</td>
								<td>{$rule->regex}</td>
								{if $rule->type == 1}
									<td>数据包明文匹配</td>
								{/if}		
								{if $rule->type == 2}
									<td>数据包 hex 匹配</td>
								{/if}								
						        </tr>
						    {/foreach}
						</table>
						{$rules->render()}
					</div>

				  </div>
				</div>

	        </div>
	      </div>

        </div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}