{include file='admin-head.tpl'}

<div class="layui-body admin-auto admin-auto-add">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">添加命令</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					<form id="auto_add_form">
					<div class="layui-form layui-form-pane">

					  <div class="layui-form-item">
					    <label class="layui-form-label">命令</label>
					    <div class="layui-input-block">
					      <textarea class="layui-textarea" id="content" rows="10" required></textarea>
					    </div>
					  </div>

					  <div class="layui-form-item">
					    <label class="layui-form-label">GPG签名</label>
					    <div class="layui-input-block">
					      <textarea class="layui-textarea" id="sign" rows="10" required></textarea>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <div class="layui-input-block">
					      <button id="submit" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 立即添加</button>
					      <a class="layui-btn layui-btn-primary" href="javascript:history.go(-1);">返回</a>
					    </div>
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
require(['jquery','validate'],function($,validate){

	jQuery.extend(jQuery.validator.messages, {  
        required: "必填内容"
	});
	
    $('#auto_add_form').validate({
        submitHandler: function(){

            $.ajax({
                type: "POST",
                url: "/admin/auto",
                dataType: "json",                
                data: {
                    content: $("#content").val(),
					sign: $("#sign").val()
                },
                success: function(data){
                    if (data.ret) {
                        {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
                        window.setTimeout("location.href=top.document.referrer", 1800);
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function(jqXHR){
                    layer.msg("发生错误：" + jqXHR.status);
                }
            });

        }
		
	})

});
</script>