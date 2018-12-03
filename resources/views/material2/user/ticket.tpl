{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<div class="layui-row">
		<h1 class="site-h1">工单<span>如遇紧急问题，提交工单等待答复（处理时间：10:00 - 21:00）</span></h1>
		<div class="layui-layout-right sub">
			<a class="layui-btn" href="/user/ticket/create"><i class="icon ptfont pticon-addnewbuttonpl"></i> 提交工单</a>
		</div>
	</div>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
	        <div class="layui-card-body">
	        	
				{$tickets->render()}
				<div class="table-over">
                <table class="layui-table">
                	<thead>
                    <tr>
						<th width="10%">操作</th>                       
                        <th width="50%">标题</th>
						<th width="20%">状态</th>
						<th width="20%">日期</th>
                    </tr>
                    </thead>
                    {foreach $tickets as $ticket}
                        <tr>
							<td>
								<a class="layui-btn layui-btn-sm" href="/user/ticket/{$ticket->id}/view">查看</a>
							</td>                            
                            <td>{$ticket->title}</td>
							{if $ticket->status==1}
							<td>开启<i class="layui-badge-dot layui-bg-green" title="开启"></i></td>
							{else}
							<td>关闭</td>
							{/if}
							<td>{$ticket->datetime()}</td>
                        </tr>
                    {/foreach}
                </table>
                </div>
                {$tickets->render()}

	        </div>
	      </div>

        </div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}