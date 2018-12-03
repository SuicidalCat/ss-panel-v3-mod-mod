{include file='page-head.tpl'}

<div class="layui-body admin-relay">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<div class="layui-row">
		<h1 class="site-h1">中转规则</h1>
		<div class="layui-layout-right sub">
			<a class="layui-btn" href="/user/relay/create"><i class="icon ptfont pticon-addnewbuttonpl"></i> 添加中转规则</a>
		</div>
	</div>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">系统中您所有的中转规则</div>
				<div class="layui-card-body">
					<p>在这里，您可以设置您的中转规则，从而将数据从一个服务器重定向到另外一个服务器。</p>
					<p>优先级越大，代表其在多个符合条件的规则并存时会被优先采用，当优先级一致时，先添加的规则会被采用。</p>
					<p>对某个节点不设置中转时，这个节点就可以当作一个普通的节点来做代理使用。</p>
				</div>
			</div>
		</div>

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					
					<div class="layui-tab layui-tab-brief">
					  <ul class="layui-tab-title">
					    <li class="layui-this">规则表</li>
					    <li>链路表</li>
					  </ul>
					  <div class="layui-tab-content">

					  	<div class="layui-tab-item layui-show">
							<div class="table-over">
								{$rules->render()}
								<table class="layui-table">
								<thead>
							    <tr>
									<th>操作</th>
									<th>ID</th>
									<th>起源节点</th>
									<th>目标节点</th>
									<th>端口</th>
									<th>优先级</th>
									</tr>
									</thead>
									{foreach $rules as $rule}
										<tr>
										<td>
											<a class="btn btn-brand" {if $rule->user_id == 0}disabled{else}href="/user/relay/{$rule->id}/edit"{/if}>编辑</a>
											<a class="btn btn-brand-accent" id="delete" value="{$rule->id}" {if $rule->user_id == 0}disabled{else}href="javascript:void(0);" onClick="delete_modal_show('{$rule->id}')"{/if}>删除</a>
										</td>
										<td>#{$rule->id}</td>
										{if $rule->source_node_id == 0}
											<td>所有节点</td>
										{else}
											<td>{$rule->Source_Node()->name}</td>
										{/if}
										{if $rule->Dist_Node() == null}
											<td>不进行中转</td>
										{else}
											<td>{$rule->Dist_Node()->name}</td>
										{/if}
										<td>{if $rule->port == 0}所有端口{else}{$rule->port}{/if}</td>
										<td>{$rule->priority}</td>
								        </tr>
								    {/foreach}
								</table>
								{$rules->render()}
							</div>
					  	</div>

					  	<div class="layui-tab-item">
					  		<div class="table-over">
							<table class="layui-table">
								<thead>
							    <tr>
									<th>端口</th>
									<th>始发节点</th>
									<th>终点节点</th>
									<th>途径节点</th>
									<th>状态</th>
									</tr>
								</thead>
									{foreach $pathset as $path}
									<tr>
									<td>{$path->port}</td>
									<td>{$path->begin_node->name}</td>
									<td>{$path->end_node->name}</td>
									<td>{$path->path}</td>
									<td>{$path->status}</td>
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
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}

<script>
require(['jquery','datatables.net'],function($,datatables){

	{if !$is_relay_able}
	$("#result").modal();
	$("#msg").html("为了中转的稳定，您需要在<a href='/user/edit'>资料编辑</a>处设置协议为以下协议之一： <br>{foreach $relay_able_protocol_list as $single_text}{$single_text}<br>{/foreach}后方可设置中转规则！");
	{/if}

	delete_modal_show = function(id){
		deleteid=id;
		layer.confirm('确定要删除？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
		  delete_id()
		}, function(){
		  layer.close()
		});
	}

	delete_id=function(){
		$.ajax({
			type:"DELETE",
			url:"/user/relay",
			dataType:"json",
			data:{
				id: deleteid
			},
			success:function(data){
				if(data.ret){
					layer.msg(data.msg);
					window.setTimeout("location.href=window.location.href",1800);
				}else{
					layer.msg(data.msg);
				}
			},
			error:function(jqXHR){
				layer.msg(data.msg+"  发生错误了");
			}
		});
	}

	$("#delete_input").click(function(){
		delete_id();
	});

})
</script>