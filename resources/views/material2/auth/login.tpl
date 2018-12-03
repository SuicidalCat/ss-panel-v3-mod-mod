{include file='theme-head.tpl'}
<body class="theme-bg">

<div id="theme-page" class="layui-container auth auth-login {if $enable_email_verify =='true'}emailverify{/if} {if $geetest_html != null}geetest{/if} {if $enable_invite_code == 'true'}invitecode{/if}">

	<div class="logo"><a href="{$config["baseUrl"]}"><em></em></a></div>

	<!--content-->
	<div class="layui-row">

		<div class="login layui-col-md6 layui-col-md-offset3 layui-col-sm10 layui-col-sm-offset1">

			<div class="nav">
				<a href="/auth/login" class="cur">登录</a>
				<a href="/auth/register">注册</a>
			</div>

			<form class="layui-form" action="javascript:void(0);"  method="POST">

			  <div class="layui-form-item">
			    <label class="layui-form-label" for="email">邮箱</label>
			    <div class="layui-input-block">
			      <input type="text" name="title" placeholder="填写邮箱地址" class="layui-input" id="email">
			    </div>
			  </div>
			  <div class="layui-form-item">
			    <label class="layui-form-label" for="passwd">密码</label>
			    <div class="layui-input-block">
			      <input type="password" name="Password" placeholder="填写密码" class="layui-input" id="passwd">
			    </div>
			  </div>

			{if $geetest_html != null}
			  <div class="layui-form-item">
			    <label class="layui-form-label" for="embed-captcha">验证码</label>
			    <div class="layui-input-block">
			      <div id="embed-captcha">
			      	<div id="wait">
		                <div class="loading">
		                    <div class="loading-dot"></div>
		                    <div class="loading-dot"></div>
		                    <div class="loading-dot"></div>
		                    <div class="loading-dot"></div>
		                </div>
		            </div>
			      </div>
			    </div>
			  </div>
			{/if}

			  <div class="layui-form-item">
			    <div class="layui-input-block">
			     	<button class="layui-btn" id="login" type="submit">登录</button>			      
			    </div>
			  </div>				

			</form>

			<div class="bt">
				<a href="/password/reset">忘记密码?</a>
			</div>

		</div>

	</div>
	<!--content:end-->

</div>

{include file='theme-foot.tpl'}
<script>
require(['jquery','domReady','geet'], function($,domReady){

	{if $geetest_html != null}
    initGeetest({
    	width: "99%",
        gt: "{$geetest_html->gt}",
        challenge: "{$geetest_html->challenge}",
        product: "embed",
        offline: {if $geetest_html->success}0{else}1{/if}
    }, function (captchaObj) {
	    captchaObj.appendTo("#embed-captcha");
	    captchaObj.onReady(function(){
			$("#wait").hide();
	    }).onSuccess(function(){
			validate = captchaObj.getValidate();
	    });
	    captcha = captchaObj;
	});
	{/if}

	domReady(function () {

		login = function(){			

			layer.load();

			{if $geetest_html != null}
	        if (typeof validate == 'undefined') {
	            layer.msg("显示验证成功后 再点登录");	
	            layer.closeAll('loading');
	            return;
	        }
	        if (!validate) {	        	
	            layer.msg("请滑动验证码来完成验证");
	            layer.closeAll('loading');
	            return;
	        }
	        {/if}

			document.getElementById("login").disabled = true;
	        $.ajax({
	            type:"POST",
	            url:"/auth/login",
	            dataType:"json",
	            data:{
	                email: $("#email").val(),
	                passwd: $("#passwd").val(),
					code: $("#code").val(),
	                remember_me: $("#remember_me:checked").val(){if $geetest_html != null},
                    geetest_challenge: validate.geetest_challenge,
                    geetest_validate: validate.geetest_validate,
                    geetest_seccode: validate.geetest_seccode{/if}
	            },
	            success:function(data){
	                if(data.ret == 1){
	                	layer.closeAll('loading');
	                	{literal}
	                    layer.msg("登录成功 跳转中...", {icon: "6"});
	                    {/literal}
	                    window.setTimeout("location.href='/user'",1800);
	                }else{
	                	layer.closeAll('loading');
	                    layer.msg(data.msg);
						document.getElementById("login").disabled = false;
						{if $geetest_html != null}
	                    captcha.reset();
	                    {/if}
			        }
	            },
	            error:function(jqXHR){
					layer.closeAll('loading');
					layer.msg("发生错误：" + jqXHR.status);
					document.getElementById("login").disabled = false;
					{if $geetest_html != null}
                    captcha.reset();
                    {/if}
			    }
	        });
	    }

	    $("html").keydown(function(event){
	        if(event.keyCode==13){
	            login();
	        }
	    });

	    $("#login").click(function(){
	        login();
	    });

	})	

})
</script>

{if $enable_email_verify =='true'}
<script>
require(['jquery'], function($){
	var wait=60;
	function time(o) {
	    if (wait == 0) {
	        o.removeAttr("disabled");
	        o.text("获取验证码");
	        wait = 60;
	    } else {
	        o.attr("disabled","disabled");
	        o.text("重新发送(" + wait + ")");
	        wait--;
	        setTimeout(function() {
	            time(o)
	        },
	        1000)
	    }
	}

	$("#email_verify").click(function () {
	    time($("#email_verify"));
	    
	    $.ajax({
	        type: "POST",
	        url: "send",
	        dataType: "json",
	        data: {
	            email: $("#email").val()
	        },
	        success: function (data) {
	            if (data.ret) {
	                layer.msg(data.msg);                        
	            } else {
	                layer.msg(data.msg);
	            }
	        },
	        error: function (jqXHR) {
	            layer.msg(data.msg+"出现了一些错误。");
	        }
	    })
	})
})
</script>
{/if}