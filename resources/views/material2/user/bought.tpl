{include file='page-head.tpl'}

<div class="layui-body user-bought">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">购买记录</h1>

	<!--content-->
	<div class="layui-row layui-col-space20" id="bought">

		<div class="layui-col-md12">
		
		<div class="layui-card">
			<div class="layui-card-body">
			{$shops->render()}
			<div class="table-over">
			<table class="layui-table">
				<colgroup>
				    <col width="10%">
				    <col width="15%">
				    <col width="35%">
				    <col width="10%">
				    <col width="15%">
				    <col width="15%">
				    <col>
				  </colgroup>
				<thead>
	                <tr>
	                    <th>购买日期</th>
	                    <th>商品名称</th>
						<th>内容</th>
						<th>价格</th>
	                    <th>续费时间</th>
						<th>续费时重置流量</th>                    
	                </tr>
	            </thead>
	            <tbody>
	                {foreach $shops as $shop}
	                <tr>
	                    <td>{$shop->datetime|date_format:'%Y-%m-%d %H:%M:%S'}</td>
	                    <td>{$shop->shop()->name}</td>
						<td>{$shop->shop()->content()}</td>
						<td>{$shop->price} 元</td>
						{if $shop->renew==0}
	                    <td>不自动续费</td>
						{else}
						<td>在 {$shop->renew_date()} 续费</td>
						{/if}
						
						{if $shop->shop()->auto_reset_bandwidth==0}
	                    <td>不自动重置</td>
						{else}
						<td>自动重置</td>
						{/if}
	                </tr>	                
	                {/foreach}	            	
	            </tbody>
            </table>
            </div>
            {if $shop@show}{else}<div class="tac">暂无</div>{/if}
			{$shops->render()}
			</div>
		</div>

		</div>

		<div class="layui-col-md12 text-center">{$smarty.now|date_format:"%Y"} @ Theme by <a href="https://t.me/serikang" target="_blank">SP</a></div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}