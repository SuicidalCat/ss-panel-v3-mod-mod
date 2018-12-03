{include file='theme-head.tpl'}
<body class="theme-bg">

<div id="theme-page" class="layui-container auth auth-reset">

	<div class="logo"><a href="{$config["baseUrl"]}"><em></em></a></div>

	<!--content-->
	<div class="layui-row">

		<div class="login layui-col-md6 layui-col-md-offset3 layui-col-sm10 layui-col-sm-offset1">

			<div class="nav">
				<a href="javascript:void()" class="cur">重置密码</a>
				<a href="/auth/login">登录</a>
				<a href="/auth/register">注册</a>
			</div>

			<div class="layui-form">

			  <div class="layui-form-item">
			    <label class="layui-form-label" for="email">邮箱</label>
			    <div class="layui-input-block">
			      <input type="text" name="email" placeholder="填写邮箱地址" class="layui-input" id="email">
			    </div>
			  </div>

			  <div class="layui-form-item">
			    <div class="layui-input-block">
			     	<button class="layui-btn" id="reset-btn" type="submit">重置密码</button>
			    </div>
			  </div>				

			</div>

		</div>

	</div>
	<!--content:end-->

</div>

{include file='theme-foot.tpl'}

<script>
require(['jquery'], function($){
	resetPassWord=function(){
            layer.msg("正在发送，请稍候...");
            $.ajax({
                type:"POST",
                url:"/password/reset",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                },
                success:function(data){
                    if(data.ret == 1){
                        {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}                       
                    }else{
                        layer.msg(data.msg);
                    }
                },
                error:function(jqXHR){
                    layer.msg(data.msg);
                }
            });
        }
        $("#reset-btn").click(function(){
            resetPassWord();
        });
})
</script>
