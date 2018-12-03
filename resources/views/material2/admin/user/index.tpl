{include file='admin-head.tpl'}

<div class="layui-body admin-user">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">用户列表</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">
			<div class="layui-card">
				<div class="layui-card-header">系统中所有用户</div>
				<div class="layui-card-body">
					显示表项: {include file='table/checkbox.tpl'}
					<div class="table-over">
						<table id="table_1" class="mdl-data-table layui-table" width="100%">
						  <thead>
						    <tr>
						      {foreach $table_config['total_column'] as $key => $value}      
						        <th class="{$key}">
						          {$value}
						          <span class="layui-table-sort layui-inline"><i class="layui-edge layui-table-sort-asc"></i><i class="layui-edge layui-table-sort-desc"></i></span>
						        </th>
						      {/foreach}
						    </tr>
						  </thead>
						  <tbody>
						  </tbody>
						</table>
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
require(['domReady','jquery','datatables.net'],function(domReady,$,datatables){


		modify_table_visible=function(id, key) {
			if(document.getElementById(id).checked)
			{
				table_1.columns( '.' + key ).visible( true );
				localStorage.setItem(window.location.href + '-haschecked-' + id, true);
			}
			else
			{
				table_1.columns( '.' + key ).visible( false );
				localStorage.setItem(window.location.href + '-haschecked-' + id, false);
			}
		}

	domReady(function(){		
		
		delete_modal_show = function(id){
			deleteid=id;
			layer.confirm('确定要删除？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
			  delete_id()
			}, function(){
			  layer.close()
			});
		}	

		delete_id = function(){
			$.ajax({
				type:"DELETE",
				url:"/admin/user",
				dataType:"json",
				data:{
					id: deleteid
				},
				success:function(data){
					if(data.ret){
						layer.msg(data.msg);
						table_1.row('#row_1_' + deleteid).remove().draw();
					}else{
						layer.msg(data.msg);
					}
				},
				error:function(jqXHR){
					layer.msg(data.msg+"  发生错误了");
				}
			});
		}

		changetouser_id=function(){
			$.ajax({
				type:"POST",
				url:"/admin/user/changetouser",
				dataType:"json",
				data:{
	              userid: changetouserid,
	              adminid: {$user->id},
	              local: '/admin/user'
				},
				success:function(data){
					if(data.ret){
						layer.msg(data.msg);
	                    window.setTimeout("location.href='/user'",{$config['jump_delay']});
					}else{
						layer.msg(data.msg);
					}
				},
				error:function(jqXHR){
					layer.msg(data.msg+"  发生错误了");
				}
			});
		}

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

		table_1 = $('#table_1').DataTable({
	      order:[[1, 'asc' ]],
			stateSave: true,
			serverSide: true,
			ajax: {
				url :"/admin/user/ajax",
                type: "POST",
			},			
			columns: [
				{ "data": "op" ,"orderable":false},
				{ "data": "id" },
				{ "data": "user_name" },
				{ "data": "remark" },
				{ "data": "email" },
				{ "data": "money" },
				{ "data": "im_type" },
				{ "data": "im_value" },
				{ "data": "node_group" },
				{ "data": "expire_in" },
				{ "data": "class" },
				{ "data": "class_expire" },
				{ "data": "passwd" },
				{ "data": "port" },
				{ "data": "method" },
				{ "data": "protocol" },
				{ "data": "obfs" },
				{ "data": "online_ip_count" ,"orderable":false},
				{ "data": "last_ss_time" ,"orderable":false},
				{ "data": "used_traffic" ,"orderable":false},
				{ "data": "enable_traffic" ,"orderable":false},
				{ "data": "last_checkin_time" ,"orderable":false},
				{ "data": "today_traffic" ,"orderable":false},
				{ "data": "enable" },
				{ "data": "reg_date" },
				{ "data": "reg_ip" },
				{ "data": "auto_reset_day" },
				{ "data": "auto_reset_bandwidth" },
				{ "data": "ref_by" },
				{ "data": "ref_by_user_name" ,"orderable":false}
			],
			"columnDefs": [
				{
					targets: [ '_all' ],
					className: 'mdl-data-table__cell--non-numeric'
				}
			],
	      {include file='table/lang_chinese.tpl'}
	    })

	var has_init = JSON.parse(localStorage.getItem(window.location.href + '-hasinit'));
	if (has_init != true) {
	    localStorage.setItem(window.location.href + '-hasinit', true);
	} else {
	    {foreach $table_config['total_column'] as $key => $value}
	        var checked = JSON.parse(localStorage.getItem(window.location.href + '-haschecked-checkbox_{$key}'));
	        if (checked == true) {
	            document.getElementById('checkbox_{$key}').checked = true;
	        } else {
	            document.getElementById('checkbox_{$key}').checked = false;
	        }
	    {/foreach}
	}

	{foreach $table_config['total_column'] as $key => $value}
	  modify_table_visible('checkbox_{$key}', '{$key}');
	{/foreach}

		$('.toggle-vis').on('change', function (e){

		   e.preventDefault();
		   console.log($(this).attr('data-column'));

		   var th = $(this).attr('data-column');
		   var tbcolumn = table_1.column('.'+th );

		   if( $(this).is(":checked") ){
		      tbcolumn.visible(!tbcolumn.visible());
		      localStorage.setItem(window.location.href + '-haschecked-checkbox_' + th, true);
		   }else{
		      tbcolumn.visible(false);
		      localStorage.setItem(window.location.href + '-haschecked-checkbox_' + th, false);
		   }

		});

	
	})

})
</script>