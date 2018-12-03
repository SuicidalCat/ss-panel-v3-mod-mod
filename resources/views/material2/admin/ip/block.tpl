{include file='admin-head.tpl'}

<div class="layui-body admin-ip admin-ip-block">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">已封禁IP</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					<form class="layui-form layui-form-pane" id="block_form">
					  <div class="layui-form-item">
					    <label class="layui-form-label">要解封的IP</label>
					    <div class="layui-input-inline">
					      <input type="text" id="ip" class="layui-input" required>
					    </div>
					    <div class="layui-input-mid">
					    	<button class="layui-btn" id="submit" type="submit"><i class="icon ptfont pticon-tickcheckmarkac"></i> 解封</button>
					    </div>
					  </div>
					</form>
				</div>
			</div>
		</div>

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">非法行为的IP</div>
				<div class="layui-card-body">
					显示表项:
	                {include file='table/checkbox.tpl'}
	                <div class="table-over">
	                {include file='table/table.tpl'}
	                </div>
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
require(['domReady','jquery','datatables.net','validate'],function(domReady,$,datatables,validate){

	jQuery.extend(jQuery.validator.messages, {  
        required: "必填内容"
	});
	
{literal}
	 $('#block_form').validate({
        rules: {
          ip: {	required: true }
        },        
        submitHandler: function() {
        	$.ajax({
		      type: "POST",
		      url: "/admin/unblock",
		      dataType: "json",
		      data: {
		          ip: $("#ip").val()
		      },
		      {/literal}
		      success: function (data) {
		          if (data.ret) {
		              layer.msg(data.msg);
		              window.setTimeout("location.href=window.location.href",1800);
		          }
				else
				{
					layer.msg(data.msg);
				}
		          // window.location.reload();
		      },
		      error: function (jqXHR) {
		          layer.msg("发生错误：" + jqXHR.status);
		      }
		  })
        }
      });

	domReady(function(){
	 	{include file='table/js_2.tpl'}
	});

})
</script>