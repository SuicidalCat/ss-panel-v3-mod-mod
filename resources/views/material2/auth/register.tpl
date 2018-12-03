{include file='theme-head.tpl'}
<body class="theme-bg">

<div id="theme-page" class="layui-container auth auth-reg {if $enable_email_verify =='true'}emailverify{/if} {if $geetest_html != null}geetest{/if} {if $enable_invite_code == 'true'}invitecode{/if}">

	<div class="logo"><a href="{$config["baseUrl"]}"><em></em></a></div>

	<!--content-->
	<div class="layui-row">				

		<div class="login layui-col-md6 layui-col-md-offset3 layui-col-sm10 layui-col-sm-offset1">

			<div class="nav">
				<a href="/auth/login">登录</a>
				<a href="/auth/register" class="cur">注册</a>
			</div>

			<form class="layui-form" action="javascript:void(0);"  method="POST">

			  <div class="layui-form-item">
			    <label class="layui-form-label" for="email">邮箱</label>
			    <div class="layui-input-block">
			      <input type="text" name="title" placeholder="用于登录和找回密码" class="layui-input" id="email">
			    </div>
			  </div>

			{if $enable_email_verify =='true'}
			  <div class="layui-form-item">
			    <label class="layui-form-label" for="email_code">邮箱验证码</label>
			    <div class="layui-input-inline">
			      <input type="text" name="title" placeholder="输入验证码" class="layui-input" id="email_code">
			    </div>
			    <div class="layui-word-aux" style="float:left">
			    	<button id="email_verify" class="layui-btn">获取验证码</button>
			    </div>
			  </div>
			{/if}

			  <div class="layui-form-item">
			    <label class="layui-form-label" for="passwd">密码</label>
			    <div class="layui-input-block">
			      <input type="password" name="Password" placeholder="" class="layui-input" id="passwd">
			    </div>
			  </div>

			  <div class="layui-form-item">
			    <label class="layui-form-label" for="repasswd">重复密码</label>
			    <div class="layui-input-block">
			      <input type="password" name="Password" placeholder="" class="layui-input" id="repasswd">
			    </div>
			  </div>

			  <div class="layui-form-item hide">
			    <label class="layui-form-label" for="imtype">选择方式</label>
			    <div class="layui-input-inline">
			    <select class="layui-select" id="imtype">
			    	<option></option>
					<option value="1" selected>微信</option>
					<option value="2">QQ</option>
					<option value="3">Google+</option>
					<option value="4">Telegram</option>
				</select>
			    </div>
			  </div>

			  <div class="layui-form-item hide">
			    <label class="layui-form-label" for="wechat">联络方式</label>
			    <div class="layui-input-inline">
			    	<input type="text" placeholder="" value="{time()}" class="layui-input" id="wechat">
			    </div>
			  </div>

			{if $enable_invite_code == 'true'}
			  <div class="layui-form-item">
			    <label class="layui-form-label" for="code">邀请码</label>
			    <div class="layui-input-block">
			      <input type="text" placeholder="填写邀请码" value="{$code}" class="layui-input" id="code">
			    </div>
			  </div>
			{/if}

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
			     	<button id="reg" type="submit" class="layui-btn">注册</button>
			    </div>
			  </div>			

			</form>

			<div class="bt"><a href="/tos" target="_blank"><i class="icon ptfont pticon-checkmarktickse"></i>注册即默认同意本站条款</a></div>		

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
		register = function(){

			layer.load();

			code = $("#code").val();
	    	{if $enable_invite_code != 'true'}
	           code = 0;
	           if ((getCookie('code'))!=''){
	           code = getCookie('code');
	          }
		    {/if}

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

            $.ajax({
                type:"POST",
                url:"/auth/register",
                dataType:"json",
                data:{
                    email: $("#email").val(),
                    name: $("#email").val(),
                    passwd: $("#passwd").val(),
                    repasswd: $("#repasswd").val(),
					wechat: $("#wechat").val(),
					imtype: $("#imtype").val(),
					code:code{if $enable_email_verify == 'true'},
					emailcode: $("#email_code").val(){/if}{if $geetest_html != null},
					geetest_challenge: validate.geetest_challenge,
                    geetest_validate: validate.geetest_validate,
                    geetest_seccode: validate.geetest_seccode
					{/if}
                },
                success:function(data){
                    if(data.ret == 1){
                    	layer.closeAll('loading');
                        {literal}
						layer.msg("注册成功 前往登录", {icon: "6"}); 
						{/literal}
                        window.setTimeout("location.href='/auth/login'", {$config['jump_delay']});
                    }else{
                    	layer.closeAll('loading');
						layer.msg(data.msg); 
                        setCookie('code','',0);
                        $("#code").val(getCookie('code'));
						{if $geetest_html != null}
						captcha.reset();
						{/if}
                    }
                },
                error:function(jqXHR){
                	layer.closeAll('loading');
					layer.msg("发生错误："+jqXHR.status);
					{if $geetest_html != null}
					captcha.reset();
					{/if}
                }
            });
        }
				
		$("#reg").click(function(){
            register();
        }); 
	})

	{*dumplin：轮子1.js读取url参数*}
	function getQueryVariable(variable)
	{
	       var query = window.location.search.substring(1);
	       var vars = query.split("&");
	       for (var i=0;i<vars.length;i++) {
	            	var pair = vars[i].split("=");
	            	if(pair[0] == variable){
	            		return pair[1];
	            	}
	       }
	       return "";
	}

	{*dumplin:轮子2.js写入cookie*}
	function setCookie(cname,cvalue,exdays)
	{
	  var d = new Date();
	  d.setTime(d.getTime()+(exdays*24*60*60*1000));
	  var expires = "expires="+d.toGMTString();
	  document.cookie = cname + "=" + cvalue + "; " + expires;
	}

	{*dumplin:轮子3.js读取cookie*}
	function getCookie(cname)
	{
	  var name = cname + "=";
	  var ca = document.cookie.split(';');
	  for(var i=0; i<ca.length; i++) 
	  {
	    var c = ca[i].trim();
	    if (c.indexOf(name)==0) return c.substring(name.length,c.length);
	  }
	  return "";
	}

	{*dumplin:读取url参数写入cookie，自动跳转隐藏url邀请码*}
	if (getQueryVariable('code')!=''){
		setCookie('code',getQueryVariable('code'),30);
		window.location.href='/auth/register'; 
	}

    {if $enable_invite_code == 'true'}
	{*dumplin:读取cookie，自动填入邀请码框*}
	if ((getCookie('code'))!=''){
		$("#code").val(getCookie('code'));
	}
	{/if}

})
</script>

{if $enable_email_verify =='true'}
<script>
require(['jquery','domReady'], function($,domReady){
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
    domReady(function () {
        $("#email_verify").click(function () {
        	layer.load();        	
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
                    	layer.closeAll('loading');
                        layer.msg(data.msg);
                    } else {
                    	layer.closeAll('loading');
                        layer.msg(data.msg)
                    }
                },
                error: function (jqXHR) {
                	layer.closeAll('loading');           	
					layer.msg(data.msg+"出现了一些错误");
                }
            })
        })
    })
})
</script>
{/if}