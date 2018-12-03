{include file='admin-head.tpl'}

<div class="layui-body admin-code admin-code-add">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">添加充值卡</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">				
				<div class="layui-card-body">
					<form class="layui-form layui-form-pane" id="code_add_form">
					  <div class="layui-form-item">
					    <label class="layui-form-label">充值卡数量</label>
					    <div class="layui-input-inline">
					      <input type="text" name="amount" id="amount" class="layui-input" required>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">充值卡金额</label>
					    <div class="layui-input-inline">
					      <input type="text" name="number" id="number" class="layui-input" required>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <div class="layui-input-block">
					      <button id="submit" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 立即添加</button>
					      <a class="layui-btn layui-btn-primary" href="javascript:history.go(-1);">返回</a>
					    </div>
					  </div>
					</form>					
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
require(['jquery','validate'], function($,validate){

	jQuery.extend(jQuery.validator.messages, {  
        required: "必填内容"
	});
	
{literal}
	 $('#code_add_form').validate({
        rules: {
          amount: {required: true},
          number: {required: true}
        },        
        submitHandler: function() {
            $.ajax({
                type: "POST",
                url: "/admin/code",
                dataType: "json",
                data: {
                    amount: $("#amount").val(),
                    number: $("#number").val()
                },
                success: function (data) {
                    if (data.ret) {
                        layer.msg(data.msg, {icon: "6"}); 
                        {/literal}
                        window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"  发生错误了。");
                }
            });
        }
	})
})
</script>