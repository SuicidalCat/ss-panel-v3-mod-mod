{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">审计<span>注意：以下规则仅用于管理禁止这些不当行为，您的隐私访问我们不会做任何记录。</span></h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
	        <div class="layui-card-body">

	        	<div class="layui-tab layui-tab-brief">
				  <ul class="layui-tab-title">
				    <li class="layui-this">审计记录</li>
				    <li><a href="/user/detect">审计规则</a></li>
				  </ul>
				  <div class="layui-tab-content">
				  	
					<div class="table-over">
						{$logs->render()}
						<table class="layui-table">
							<thead>
						    <tr>
						        <th>ID</th>
						        <th>节点ID</th>
						        <th>节点名称</th>
						        <th>规则ID</th>
						        <th>名称</th>
						        <th>描述</th>
							<th>正则表达式</th>
							<th>类型</th>
							<th>时间</th>
						    </tr>
						    </thead>
						    {foreach $logs as $log}
								{if $log->DetectRule() != null}
									<tr>
									<td>#{$log->id}</td>
									<td>{$log->node_id}</td>
									<td>{$log->Node()->name}</td>
									<td>{$log->list_id}</td>
									<td>{$log->DetectRule()->name}</td>
									<td>{$log->DetectRule()->text}</td>
									<td>{$log->DetectRule()->regex}</td>
									{if $log->DetectRule()->type == 1}
										<td>数据包明文匹配</td>
									{/if}		
									{if $log->DetectRule()->type == 2}
										<td>数据包 hex 匹配</td>
									{/if}
									<td>{date('Y-m-d H:i:s',$log->datetime)}</td>						
									</tr>
								{/if}
						    {/foreach}
						</table>
						{$logs->render()}
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