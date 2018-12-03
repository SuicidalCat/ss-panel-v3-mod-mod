{include file='admin-head.tpl'}

<div class="layui-body admin-detect admin-detect-add">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">添加审计规则</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">审计规则</div>
				<div class="layui-card-body">
					<form class="layui-form layui-form-pane" id="detect_add_form">
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则名称</label>
					    <div class="layui-input-inline">
					      <input type="text" id="name" class="layui-input" required>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则描述</label>
					    <div class="layui-input-block">
					      <input type="text" id="text" class="layui-input" required>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则正则表达式</label>
					    <div class="layui-input-block">
					      <textarea name="regex" id="regex" cols="30" rows="10" class="layui-textarea" required></textarea>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则类型</label>
					    <div class="layui-input-inline">
					      	<select id="type" name="type">
								<option value="1">数据包明文匹配</option>
								<option value="2">数据包 hex 匹配</option>
							</select>
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
	{literal}
	jQuery.extend(jQuery.validator.messages, {  
        required: "必填内容"
	});

	$('#detect_add_form').validate({
		rules: {
		  name: {required: true},
		  text: {required: true},
		  regex: {required: true}
		},

		submitHandler: function() {
			
			$.ajax({

				type: "POST",
				url: "/admin/detect",
				dataType: "json",
				data: {
					    name: $("#name").val(),
					    text: $("#text").val(),
					    regex: $("#regex").val(),
					    type: $("#type").val()
				
					},
					success: function (data) {
					    if (data.ret) {
							layer.msg(data.msg, {icon: 6}); 
							{/literal}
							window.setTimeout("location.href=top.document.referrer",1800);
					    } else {
							layer.msg(data.msg);
					    }
					},
					error: function (jqXHR) {
					    layer.msg(data.msg+"  发生错误了。");
					}
				});
			}
		});

})
</script>