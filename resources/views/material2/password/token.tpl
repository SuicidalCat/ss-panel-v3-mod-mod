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
			    <label class="layui-form-label" for="password">密码</label>
			    <div class="layui-input-block">
			      <input type="text" class="layui-input" id="password">
			    </div>
			  </div>

			  <div class="layui-form-item">
			    <label class="layui-form-label" for="repasswd">重复密码</label>
			    <div class="layui-input-block">
			      <input type="text" class="layui-input" id="repasswd">
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
            $.ajax({
                type:"POST",
                url:"/password/token/{$token}",
                dataType:"json",
                data:{
                    password: $("#password").val(),
                    repasswd: $("#repasswd").val(),
                },
                success:function(data){
                    if(data.ret){
						{literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
                        window.setTimeout("location.href='/auth/login'", {$config['jump_delay']});
                    }else{
                        layer.msg(data.msg);
                    }
                },
                error:function(jqXHR){
                    layer.msg("发生错误："+jqXHR.status);
                    console.log(removeHTMLTag(jqXHR.responseText));
                }
            });
        }
        $("html").keydown(function(event){
            if(event.keyCode==13){
                reset();
            }
        });
        $("#reset-btn").click(function(){
            resetPassWord();
        });
})
</script>
