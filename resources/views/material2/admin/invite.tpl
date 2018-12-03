{include file='admin-head.tpl'}

<div class="layui-body admin-invite">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">邀请码</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">邀请码 <span>公共邀请码功能已废弃,如需开放注册.config.php中enable_invite_code设置为false</span></div>
				<div class="layui-card-body">

					<div class="layui-form layui-form-pane">
						<div class="layui-form-item">
						    <label class="layui-form-label" for="uid">邀请码用户</label>
						    <div class="layui-input-inline">
						      <input type="text" class="layui-input" id="uid" placeholder="需要增加邀请码数量的用户">
						    </div>
						    <div class="layui-form-mid layui-word-aux">
						    	数字0为公开，其他数字：对应用户的ID，或者输入用户的完整邮箱
						    </div>
						</div>
						<div class="layui-form-item">
						    <label class="layui-form-label" for="num">邀请码数量</label>
						    <div class="layui-input-inline">
						      <input type="number" class="layui-input" id="num">
						    </div>
						    <div class="layui-form-mid layui-word-aux">
						    	邀请码数量，以.config.php里设置为准
						    </div>						    
						</div>
						<div class="layui-form-item">
						    <div class="layui-input-block">
						      <a id="invite" class="layui-btn">立即提交</a>
						      <!--<a href="/code" class="layui-btn layui-btn-primary layui-btn-xs" target="_blank"> <i class="icon ptfont pticon-clipattachmentpa"></i> 查看已有邀请码</a>-->
						    </div>
						</div>
					</div>

				</div>
			</div>
		</div>		

    </div>
	<!--content:end-->


	<h1 class="site-h1">返利</h1>

	<div class="layui-row layui-col-space20">
	
		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">返利记录</div>
				<div class="layui-card-body">
					显示表项: {include file='table/checkbox.tpl'}
					<div class="table-over">
					{include file='table/table.tpl'}
					</div>
				</div>
			</div>
		</div>

	</div>

</div>
</div>
</div>

{include file='admin-foot.tpl'}

<script>
require(['jquery','datatables.net','domReady'],function($,datatables,domReady){

	$("#invite").click(function () {
	    $.ajax({
	        type: "POST",
	        url: "/admin/invite",
	        dataType: "json",
	        data: {
	            prefix: $("#prefix").val(),
	            uid: $("#uid").val(),
	            num: $("#num").val()
	        },
	        success: function (data) {
	            if (data.ret) {
	                {literal}
					layer.msg(data.msg, {icon: "6"}); 
					{/literal}
	                window.setTimeout("location.href='/admin/invite'",1800);
					}
	            else
				{
					layer.msg(data.msg);
				}
	        },
	        error: function (jqXHR) {	            
	            layer.msg("发生错误：" + jqXHR.status);
	        }
	    })
	});

	domReady(function(){
	 	{include file='table/js_2.tpl'}
	});
})
</script>