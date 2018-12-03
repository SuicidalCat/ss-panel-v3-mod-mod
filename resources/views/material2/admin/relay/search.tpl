{include file='admin-head.tpl'}

<div class="layui-body admin-relay admin-relay-search">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">中转链路搜索</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					<form class="layui-form layui-form-pane" id="block_form">
					  <div class="layui-form-item">
					    <label class="layui-form-label">输入用户ID</label>
					    <div class="layui-input-inline">
					      <input type="text" id="search" class="layui-input" value="" required>
					    </div>
					    <div class="layui-input-mid">
					    	<button class="layui-btn" id="search_button" type="submit"><i class="icon ptfont pticon-magnifiersearchd"></i> 搜索</button>
					    </div>
					  </div>
					</form>
				</div>
			</div>
		</div>

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">系统中这位用户的链路</div>
				<div class="layui-card-body">
					<table class="mdl-data-table layui-table" id="table_1" cellspacing="0" width="100%">
						<thead>
			              <tr>
			              <th>端口</th>
			              <th>始发节点</th>
			              <th>终点节点</th>
			              <th>途径节点</th>
			              <th>状态</th>
			              </tr>
						</thead>
						<tbody>
			              {foreach $pathset as $path}
			              <tr>
			              <td>{$path->port}</td>
			              <td>{$path->begin_node->name}</td>
			              <td>{$path->end_node->name}</td>
			              <td>{$path->path}</td>
			              <td>{$path->status}</td>
			              </tr>
			              {/foreach}
						</tbody>
            		</table>
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

 	var table = $('#table_1').DataTable({
		"columnDefs": [
			{
					targets: [ '_all' ],
					className: 'mdl-data-table__cell--non-numeric'
			}
		],
		{include file='table/lang_chinese.tpl'}
	});		

	var search=function(){
		window.location.href="/admin/relay/path_search/"+$("#search").val();
	}

	$("#search_button").on("click",function(){
		if($("#search").val()!="")
		{
			search();
		}
	})

})
</script>