{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">鏈接審計</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
	        <div class="layui-card-body">
	        <div class="layui-tab layui-tab-brief">
				  <div class="layui-tab-content">			  	
					<div class="table-over">
						{$logs->render()}
						<table class="layui-table">
							<thead>
						    <tr>
						        <th>審計ID</th>
						        <th>接入點ID</th>
						        <th>接入點名稱</th>
						        <th>審計規則ID</th>
										<th>正則表達式</th>
										<th>類型</th>
										<th>時間戳</th>
						    </tr>
						    </thead>
						    {foreach $logs as $log}
								{if $log->DetectRule() != null}
									<tr>
									<td>#{$log->id}</td>
									<td>{$log->node_id}</td>
									<td>{$log->Node()->name}</td>
									<td>{$log->list_id}</td>
									<td>{$log->DetectRule()->regex}</td>
									{if $log->DetectRule()->type == 1}
										<td>數據封包明文匹配</td>
									{/if}		
									{if $log->DetectRule()->type == 2}
										<td>數據封包 hex 匹配</td>
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