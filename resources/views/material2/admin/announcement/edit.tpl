{include file='admin-head.tpl'}

<div class="layui-body admin-announcement admin-announcement-edit">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">编辑公告 #{$ann->id}</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
				
				<div class="layui-form layui-form-pane">
				  <div class="layui-form-item">
				    <label class="layui-form-label">公告内容</label>
				    <div class="layui-input-block">
				      <div id="content">{$ann->content}</div>
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <div class="layui-input-block">				      
				      <button id="submit-btn" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 提交修改</button>
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
    //editor.customConfig.menus = ['head','foreColor','link','emoticon','image','undo','redo']
    //editor.customConfig.colors = ['#ff4757','#1e90ff','#ffa502','#2ed573']
    editor.create();

    domReady(function () {

		submit=function(){			
			$.ajax({
                type: "PUT",
                url: "/admin/announcement/{$ann->id}",
                dataType: "json",
                data: {
                    content: editor.txt.html(),
					markdown: editor.txt.html()
                },
                success: function (data) {
                    if (data.ret) {
                        {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
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
