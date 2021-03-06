{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">查看工单</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
          	<div class="layui-card-header">添加回复</div>
	        <div class="layui-card-body">

	        	<div class="layui-form layui-form-pane">
				  <div class="layui-form-item">
				    <label class="layui-form-label">内容</label>
				    <div class="layui-input-block">
				      <div id="content"></div>
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <div class="layui-input-block">				      
				      <button id="submit-btn" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 回复</button>
				      <button id="close-btn" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 回复并关闭工单</button>
				      <a class="layui-btn layui-btn-primary" href="/user/ticket">返回</a>
				    </div>
				  </div>
				</div>

	        </div>
	      </div>

        </div>

        <div class="layui-col-md12">

			{$ticketset->render()}
			{foreach $ticketset as $ticket}
			<div class="layui-card">
				<div class="layui-card-header"> <img style="width:30px" class="layui-btn-radius" src="{$ticket->User()->gravatar}"> {$ticket->User()->user_name} 
					<small>{$ticket->datetime()}</small></div>
				<div class="layui-card-body">
					{$ticket->content}
				</div>
			</div>
			{/foreach}
			{$ticketset->render()}

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
	            type: "PUT",
	            url: "/user/ticket/{$id}",
	            dataType: "json",
	            async: true,
	            data: {
	                "content": editor.txt.html(),
					"title": $("#title").val(),
					"status":status
	            },
	            success: function (data) {
	                if (data.ret) {
	                    {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
	                    window.setTimeout("location.reload()",1800);
	                    return;
	                } else {
	                    layer.msg(data.msg);
	                }
	            },
	            error: function (jqXHR) {
	                layer.msg("发生错误：" + jqXHR.status);
	            }
	        });
	    }

	    closeticket=function(){
	        $.ajax({
	            type: "PUT",
	            url: "/user/ticket/{$id}",
	            dataType: "json",
	            async: true,
	            data: {
	                "content": editor.txt.html(),
					"title": $("#title").val(),
					"status":status
	            },
	            success: function (data) {
	                if (data.ret) {
	                    layer.msg(data.msg);
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
	    }

	    $("#submit-btn").click(function () {
			status=1;
	        submit();
	    });

	    $("#close-btn").click(function () {
			status=0;
	        closeticket();
	    });

	})

})
</script>