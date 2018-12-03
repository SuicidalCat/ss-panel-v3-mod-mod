{include file='admin-head.tpl'}

<div class="layui-body admin-detect admin-detect-edit">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">编辑审计规则 #{$rule->id}</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
					<form class="layui-form layui-form-pane" id="detect_edit_form">
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则名称</label>
					    <div class="layui-input-inline">
					      <input type="text" id="name" class="layui-input" value="{$rule->name}" required>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则描述</label>
					    <div class="layui-input-block">
					      <input class="layui-input" id="text" name="text" type="text" value="{$rule->text}" required>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则正则表达式</label>
					    <div class="layui-input-block">
					      <input class="layui-input" id="regex" name="regex" type="text"  value="{$rule->regex}" required>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">规则类型</label>
					    <div class="layui-input-inline">
					     	<select id="type" name="type">
								<option value="1" {if $rule->type == 1}selected{/if}>数据包明文匹配</option>
								<option value="2" {if $rule->type == 2}selected{/if}>数据包 hex 匹配</option>
							</select>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <div class="layui-input-block">
					      <button id="submit" type="submit" class="layui-btn"><i class="icon ptfont pticon-editupdatepencil"></i> 提交修改</button>
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
{literal}
<script>
require(['jquery','validate'], function($,validate){

	jQuery.extend(jQuery.validator.messages, {  
        required: "必填内容"
	}); 

	$('#detect_edit_form').validate({
		rules: {
		  name: {required: true},
		  text: {required: true},
		  regex: {required: true}
		},

		submitHandler: function() {
		{/literal}	
			
			
		$.ajax({

				type: "PUT",
				url: "/admin/detect/{$rule->id}",
				dataType: "json",
				
				data: {
					    name: $("#name").val(),
					    text: $("#text").val(),
					    regex: $("#regex").val(),
					    type: $("#type").val()
				{literal}
					},
					success: function (data) {
					    if (data.ret) {
							layer.msg(data.msg, {icon: 6}); 
									{/literal}
						window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
									{literal}
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
{/literal}