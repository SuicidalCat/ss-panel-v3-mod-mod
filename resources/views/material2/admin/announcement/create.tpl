{include file='admin-head.tpl'}

<div class="layui-body admin-announcement admin-announcement-create">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">添加公告</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
				
				<div class="layui-form layui-form-pane">
				  <div class="layui-form-item">
				    <label class="layui-form-label">公告内容</label>
				    <div class="layui-input-block">
				      <div id="content"></div>
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <label class="layui-form-label">VIP等级</label>
				    <div class="layui-input-inline">
				      <input type="text" id="vip" class="layui-input">
				    </div>
				    <div class="layui-form-mid layui-word-aux">0为不分级，发送给高于这个等级的用户 </div>
				  </div>
				  <div class="layui-form-item">
                    <label class="layui-form-label">是否发送邮件</label>
                    <div class="layui-input-inline">
                        <input type="checkbox" id="issend" lay-skin="switch" lay-text="开启|关闭">
                    </div>
                </div>
				  <div class="layui-form-item">
				    <div class="layui-input-block">
				      <button id="submit-btn" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 立即添加</button>
				      <a class="layui-btn layui-btn-primary" href="/admin/announcement">返回</a>
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

{include file='admin-foot.tpl'}
<script>
require(['domReady','jquery','editor'],function(domReady,$,E){

	var editor = new E('#content')
    editor.create();

    domReady(function () {

		submit=function(){
			if(document.getElementById('issend').checked)
			{
				var issend=1;
			}
			else
			{
				var issend=0;
			}

			$.ajax({
                type: "POST",
                url: "/admin/announcement",
                dataType: "json",
                data: {
                    content: editor.txt.html(),
					markdown: editor.txt.html(),
					vip: $("#vip").val(),
                  	issend: issend
                },
                success: function (data) {
                    if (data.ret) {
                        layer.msg(data.msg);
                        window.setTimeout("location.href=top.document.referrer",1800);
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg("发生错误：" + jqXHR.status);
                }
            });

		return false;
		
		}

		$("#submit-btn").click(function(){
	        submit();
	        return false;
	    });

	})
})
</script>
