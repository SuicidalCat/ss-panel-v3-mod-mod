{include file='page-head.tpl'}

<div class="layui-body ticket-create">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">提交工单</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
	        <div class="layui-card-body" style="padding-top:20px">
	        	
	        	<div class="layui-form layui-form-pane">

				  <div class="layui-form-item">
				    <label class="layui-form-label">标题</label>
				    <div class="layui-input-block">
				      <input type="text" id="title" class="layui-input">
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <label class="layui-form-label">内容</label>
				    <div class="layui-input-block">
				      <div id="content"></div>
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <div class="layui-input-block">
				      <button id="submit-btn" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 立即提交</button>
				      <a class="layui-btn layui-btn-primary" href="javascript:history.go(-1);">返回</a>
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
require(['domReady','jquery','editor'],function(domReady,$,E){

	var editor = new E('#content')
    editor.customConfig.menus = ['head','link','emoticon','image','undo','redo']
    editor.create();

    domReady(function () {
		submit=function(){
			$.ajax({
	            type: "POST",
	            url: "/user/ticket",
	            dataType: "json",
	            data: {
	                content: editor.txt.html(),
					title: $("#title").val()
	            },
	            success: function (data) {
	                if (data.ret){
	                    {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
	                    window.setTimeout("location.href=top.document.referrer",1800);
	                    return;
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