{include file='page-head.tpl'}

<div class="layui-body user-announcement">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">系統公告</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
	        <div class="layui-card-body">
	        	
	        	<ul class="layui-timeline">
				{foreach $anns as $ann}
				  <li class="layui-timeline-item">
				    <i class="layui-icon layui-icon-circle layui-timeline-axis"></i>
				    <div class="layui-timeline-content layui-text">
				      <span class="layui-timeline-title"> #{$ann->id} - {$ann->date} </span>  
				      	<blockquote>
				      		{$ann->content}
				      	</blockquote>
				    </div>
				  </li>
				{/foreach}
				  <li class="layui-timeline-item">
				    <i class="layui-icon layui-icon-circle layui-timeline-axis"></i>
				    <div class="layui-timeline-content layui-text">
				      <div class="layui-timeline-title">欢迎~</div>
				    </div>
				  </li>
				</ul>

	        </div>
	      </div>

        </div>

        <div class="layui-col-md12 text-center">{$smarty.now|date_format:"%Y"} &copy; {$config["appName"]} <a href="/staff" target="_blank">Staff</a></div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}