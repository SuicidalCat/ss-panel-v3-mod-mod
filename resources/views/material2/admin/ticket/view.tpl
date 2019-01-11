{include file='admin-head.tpl'}

<div class="layui-body admin-ticket admin-ticket-view">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">查看工单</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-body">
				
				<div class="layui-form layui-form-pane">
				  <div class="layui-form-item">
				    <label class="layui-form-label">工单内容</label>
				    <div class="layui-input-block">
				      <div id="content"></div>
				    </div>
				  </div>
				  <div class="layui-form-item">
				    <div class="layui-input-block">				      
				      <button id="submit-btn" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 回复</button>
				      <button id="close-btn" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 回复并关闭</button>				      
				      
				      <button id="close_directly" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 直接关闭</button>

				      <a class="layui-btn layui-btn-primary" id="changetouser" href="javascript:void(0);" onClick="changetouser_modal_show()"><i class="icon ptfont pticon-Userpersonavtar"></i> 切换为该用户</a>
				      
				      <a class="layui-btn layui-btn-primary" href="javascript:history.go(-1);">返回</a>
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
					<small>{$ticket->datetime()}<small></div>
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

{include file='admin-foot.tpl'}
<script>
require(['domReady','jquery','editor'],function(domReady,$,E){
	var editor = new E('#content')
    editor.customConfig.menus = ['head','foreColor','link','emoticon','image','undo','redo']
    editor.customConfig.colors = ['#ff4757','#1e90ff','#ffa502','#2ed573']
    editor.create();

    domReady(function () {

		submit=function(){
			$.ajax({
                type: "PUT",
                url: "/admin/ticket/{$id}",
                dataType: "json",
                data: {
                    content: editor.txt.html(),
					title: $("#title").val(),
					status:status
                },
                success: function (data) {
                    if (data.ret) {
                        {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
                        window.setTimeout("location.reload()",1800);
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
	            url: "/admin/ticket/{$id}",
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

	    $('#close_directly').on('click', function(){
            status = 0;
            $(this).html('提交中……').prop("disabled",true);
            $.ajax({
                type: "PUT",
                url: "/admin/ticket/{$id}",
                dataType: "json",
                data: {
                    content: '这条工单已被关闭',
                    status
                },
                success: function (data) {
                    if (data.ret) {
                        {literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
                        window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: function (jqXHR) {
                    layer.msg("发生错误：" + jqXHR.status);
                }
            });
        });

		$("#submit-btn").click(function () {
			$(this).html('提交中……').prop("disabled",true);
			status=1;
            submit();
        });
		
		$("#close-btn").click(function () {
			$(this).html('提交中……').prop("disabled",true);
			status=0;
            closeticket();
        });

        //
        changetouser_modal_show=function(id) {
			changetouserid=id;
			layer.confirm('确定要切换？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
			  changetouser_id()
			}, function(){
			  layer.close()
			});
		}

        changetouser_id=function(){
			$.ajax({
				type:"POST",
				url:"/admin/user/changetouser",
				dataType:"json",
				data:{
	              userid: {$ticket->User()->id},
	              adminid: {$user->id},
	              local: '/admin/ticket/'+{$ticket->id}+'/view'
				},
				success:function(data){
					if(data.ret){
						{literal}
						layer.msg(data.msg, {icon: "6"}); 
						{/literal}
	                    window.setTimeout("location.href='/user'",1800);
					}else{
						layer.msg(data.msg);
					}
				},
				error:function(jqXHR){				
					layer.msg(data.msg+"  发生错误了。");
				}
			});
		}
	  	$("#changetouser_input").click(function(){
			changetouser_id();
		});

        //

	})
})
</script>
