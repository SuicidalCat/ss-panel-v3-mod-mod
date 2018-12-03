{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">节点观察</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

			<div class="layui-card">
			<div class="layui-card-body">

				<div class="layui-tab layui-tab-brief">
				  <ul class="layui-tab-title">
				    <li class="layui-this">流量记录</li>
				    <li><a href="/user/lookingglass">延迟记录</a></li>
				  </ul>
				  <div class="layui-tab-content">
				  	
				  	<div class="layui-tab-item layui-show">
				  		<p>部分节点不支持流量记录.此处只展示最近 72 小时的记录，粒度为分钟。</p>
				  		<div id="log_chart" style="height: 300px; width: 100%;"></div>
				  	</div>

				  </div>
				</div>

			</div>
			</div>
		</div>

		<div class="layui-col-md12 text-center">{$smarty.now|date_format:"%Y"} &copy; {$config["appName"]} <a href="/staff" target="_blank">Staff</a>  / Theme By <a href="https://t.me/serikang" target="_blank">Sp</a></div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}

<script>
require(['canvasjs'], function(Chart){

	window.onload = function () {
			var log_chart = new CanvasJS.Chart("log_chart",
			{
				zoomEnabled: true,
				title:{
					text: "最近72小时的流量消耗",
					fontSize: 16
					
				},  
				animationEnabled: true,
				axisX: {
					title:"时间",
					labelFontSize: 14,
					titleFontSize: 18                            
				},
				axisY:{
					title: "流量/KB",
					lineThickness: 2,
					labelFontSize: 14,
					titleFontSize: 18
				},

				data: [
				{        
					type: "scatter", 
					{literal}														
					toolTipContent: "<span style='\"'color: {color};'\"'><strong>产生时间: </strong></span>{x} <br/><span style='\"'color: {color};'\"'><strong>流量: </strong></span>{y} KB <br/><span style='\"'color: {color};'\"'><strong>产生节点: </strong></span>{jd}",
					{/literal}
					
					dataPoints: [
					
					
					{$i=0}
					{foreach $logs as $single_log}
						{if $i==0}
							{literal}
							{
							{/literal}
								x: new Date({$single_log->log_time*1000}), y:{$single_log->totalUsedRaw()},jd:"{$single_log->node()->name}"
							{literal}
							}
							{/literal}
							{$i=1}
						{else}
							{literal}
							,{
							{/literal}
								x: new Date({$single_log->log_time*1000}), y:{$single_log->totalUsedRaw()},jd:"{$single_log->node()->name}"
							{literal}
							}
							{/literal}
						{/if}
					{/foreach}
					
					]
				}
				
				]
			});

		log_chart.render();
	}

});
</script>