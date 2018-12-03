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
				    <li><a href="/user/trafficlog">流量记录</a></li>
				    <li class="layui-this">延迟记录</li>
				  </ul>
				  <div class="layui-tab-content">

				  	<div class="layui-tab-item layui-show">
				  		<p>此处只展示最近{$hour}小时的记录.测试节点来自 <a href="http://speedtest.net" target="_blank">Speedtest</a>，数据仅供参考~</p>
				  		<div class="table-over">
			        		<table class="layui-table">
			        			<colgroup>
								    <col width="15%">
								    <col>
								</colgroup>
			        			<thead>
								<tr>
									<th>节点</th>
									<th>电信延迟</th>
									<th>电信下载速度</th>
									<th>电信上传速度</th>
									<th>联通延迟</th>
									<th>联通下载速度</th>
									<th>联通上传速度</th>
									<th>移动延迟</th>
									<th>移动下载速度</th>
									<th>移动上传速度</th>
								</tr>
								</thead>
								{foreach $speedtest as $single}
									<tr>
										<td>{$single->node()->name}</td>
										<td>{$single->telecomping}</td>
										<td>{$single->telecomeupload}</td>
										<td>{$single->telecomedownload}</td>
										<td>{$single->unicomping}</td>
										<td>{$single->unicomupload}</td>
										<td>{$single->unicomdownload}</td>
										<td>{$single->cmccping}</td>
										<td>{$single->cmccupload}</td>
										<td>{$single->cmccdownload}</td>
									</tr>
								{/foreach}
							</table>
			        	</div>
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