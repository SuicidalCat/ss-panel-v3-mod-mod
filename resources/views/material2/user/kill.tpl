{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">注销删除</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
          	<div class="layui-card-body">
          		<h4>注意！</h4>
				<p>帐号删除后，您的所有数据都会被<b>真实地</b>删除。</p>
				<p>如果想重新使用本网站提供的服务，您需要重新注册。</p>
          	</div>
	        <div class="layui-card-body">
	        	
	        	<div class="layui-form layui-form-pane">
				  <div class="layui-form-item">
				    <label class="layui-form-label">输入密码</label>
				    <div class="layui-input-inline">
				      <input id="passwd" type="password" class="layui-input">
				    </div>
				  </div>				   
				  <div class="layui-form-item">
				    <div class="layui-input-block">
				      <button class="layui-btn" id="kill"><i class="icon ptfont pticon-deletetrashdust"></i> 注销账号</button>
				    </div>
				  </div>
				</div>

	        </div>
	      </div>

        </div>        


    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}

<script>
require(['domReady','jquery'],function(domReady,$){

	kill_account_btn = function(){
		layer.confirm('确定要注销删除？', {
		  btn: ['确定','取消'] //按钮
		}, function(){
		  kill_account()
		}, function(){
		  layer.close()
		});
	}

	kill_account = function(){
		$.ajax({
                type: "POST",
                url: "kill",
                dataType: "json",
                data: {
                    passwd: $("#passwd").val(),
                },
                success: function (data) {
                    if (data.ret) {
                       {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
                        window.setTimeout("location.href='/'",1800);
                    } else {
                        layer.msg(data.msg); 
                    }
                },
                error: function (jqXHR) {
                    layer.msg("发生错误：" + jqXHR.status + data.msg); 
                }
            })
	}

	domReady(function(){
        $("#kill").click(function () {
            kill_account_btn();
        })
    })

})
</script>