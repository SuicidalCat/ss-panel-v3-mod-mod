{include file='admin-head.tpl'}

<div class="layui-body admin-user admin-user-edit">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<!--title-->
	<h1 class="site-h1">用户编辑 #{$edit_user->id}</h1>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md6">
			<div class="layui-card">
				<div class="layui-card-header">用户信息</div>
				<div class="layui-card-body">

					<div class="layui-form layui-form-pane">
					  <div class="layui-form-item">
					    <label class="layui-form-label">邮箱</label>
					    <div class="layui-input-inline">
					      <input id="email" type="email" value="{$edit_user->email}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">备注</label>
					    <div class="layui-input-inline">
					      <input type="text" id="remark" value="{$edit_user->remark}" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	仅对管理员可见
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">密码</label>
					    <div class="layui-input-inline">
					      <input type="password" id="pass" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	不修改请留空
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">是否管理员</label>
					    <div class="layui-input-inline">
					      <input type="checkbox" {if $edit_user->is_admin==1}checked{/if} id="is_admin" lay-skin="switch" lay-text="是|否">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">用户启用</label>
					    <div class="layui-input-inline">
					       <input type="checkbox" {if $edit_user->enable==1}checked{/if} id="enable" lay-skin="switch" lay-text="是|否">
					    </div>
					  </div>
						<div class="layui-form-item">
							<label class="layui-form-label">二次验证启用</label>
							<div class="layui-input-inline">
								<input type="checkbox" {if $edit_user->ga_enable==1}checked{/if} id="ga_enable" lay-skin="switch" lay-text="是|否">
							</div>
						</div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">金钱</label>
					    <div class="layui-input-inline">
					      <input type="text" id="money" value="{$edit_user->money}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">端口模式</label>
					    <div class="layui-input-inline">
					      <select id="is_multi_user" name="is_multi_user">
							<option value="0" {if $edit_user->is_multi_user==0}selected{/if}>非单端口多用户端口</option>
							<option value="1" {if $edit_user->is_multi_user==1}selected{/if}>混淆式单端口多用户端口</option>
							<option value="2" {if $edit_user->is_multi_user==2}selected{/if}>协议式单端口多用户端口</option>
						</select>
					    </div>
					  </div>
					</div>

				</div>
			</div>
		</div>


		<div class="layui-col-md6">
			<div class="layui-card">
				<div class="layui-card-header">端口信息</div>
				<div class="layui-card-body">

					<div class="layui-form layui-form-pane">
					  <div class="layui-form-item">
					    <label class="layui-form-label">连接端口</label>
					    <div class="layui-input-inline">
					      <input id="port" type="text" value="{$edit_user->port}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">连接密码</label>
					    <div class="layui-input-inline">
					      <input type="text" id="passwd" type="text" value="{$edit_user->passwd}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">自定义加密</label>
					    <div class="layui-input-block">
					      <input id="method" type="text" value="{$edit_user->method}" class="layui-input">					     
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">自定义协议</label>
					    <div class="layui-input-block">
					      <input id="protocol" type="text" value="{$edit_user->protocol}" class="layui-input">

					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">自定义协议参数</label>
					    <div class="layui-input-block">
					      <input id="protocol_param" type="text" value="{$edit_user->protocol_param}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">自定义混淆方式</label>
					    <div class="layui-input-block">
					      <input id="obfs" type="text" value="{$edit_user->obfs}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">自定义混淆参数</label>
					    <div class="layui-input-block">
					      <input id="obfs_param" type="text" value="{$edit_user->obfs_param}" class="layui-input">
					    </div>
					  </div>

					</div>
				</div>
			</div>
		</div>

		<div class="layui-col-md6">
			<div class="layui-card">
				<div class="layui-card-header">套餐信息</div>
				<div class="layui-card-body">
					<div class="layui-form layui-form-pane">
					  <div class="layui-form-item">
					    <label class="layui-form-label">总流量(GB)</label>
					    <div class="layui-input-inline">
					      <input id="transfer_enable" type="text" value="{$edit_user->enableTrafficInGB()}" class="layui-input">
					    </div>
					  </div>
						<div class="layui-form-item">
					    <label class="layui-form-label">已用流量</label>
					    <div class="layui-input-inline">
					      <input id="usedTraffic" type="text" value="{$edit_user->usedTraffic()}" readonly class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">自动重置流量日</label>
					    <div class="layui-input-inline">
					      <input id="auto_reset_day" type="number" value="{$edit_user->auto_reset_day}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">重置流量值(GB)</label>
					    <div class="layui-input-inline">
					      <input id="auto_reset_bandwidth" type="number" value="{$edit_user->auto_reset_bandwidth}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">可用邀请数量</label>
					    <div class="layui-input-inline">
					      <input id="invite_num" type="number" value="{$edit_user->invite_num}" class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">邀请人ID</label>
					    <div class="layui-input-inline">
					      <input id="ref_by" type="text" value="{$edit_user->ref_by}" readonly class="layui-input">
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">用户群组</label>
					    <div class="layui-input-inline" style="width:100px">
					      <input id="group" type="number" value="{$edit_user->node_group}" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	用户能访问等于此数字或0的节点
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">用户级别</label>
					    <div class="layui-input-inline" style="width:100px">
					      <input id="class" type="number" value="{$edit_user->class}" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	用户能访问等级≤这个数字的节点
					    </div>
					  </div>
					  
					</div>
				</div>
			</div>
		</div>

		<div class="layui-col-md6">
			<div class="layui-card">
				<div class="layui-card-header">节点信息</div>
				<div class="layui-card-body">
					<div class="layui-form layui-form-pane">
					<div class="layui-form-item">
					    <label class="layui-form-label">用户等级过期时间</label>
					    <div class="layui-input-inline">
					      <input id="class_expire" type="text" value="{$edit_user->class_expire}" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	不过期就请不要动
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">用户账户过期时间</label>
					    <div class="layui-input-inline">
					      <input id="expire_in" type="text" value="{$edit_user->expire_in}" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	不过期就请不要动
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">用户限速(Mbps)</label>
					    <div class="layui-input-inline" style="width:100px">
					      <input id="node_speedlimit" type="text" value="{$edit_user->node_speedlimit}" class="layui-input">
					    </div>
					     <div class="layui-form-mid layui-word-aux">
					    	节点里所限速度 (0为不限制)
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">用户同时连接IP数</label>
					    <div class="layui-input-inline">
					      <input id="node_connector" type="text" value="{$edit_user->node_connector}" class="layui-input">
					    </div>
					    <div class="layui-form-mid layui-word-aux">
					    	0为不限制
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">禁止用户访问的IP</label>
					    <div class="layui-input-block">
					      <textarea class="layui-textarea" placeholder="一行一个" id="forbidden_ip" rows="3">{$edit_user->get_forbidden_ip()}</textarea>
					    </div>
					  </div>
					  <div class="layui-form-item">
					    <label class="layui-form-label">禁止用户访问的端口</label>
					    <div class="layui-input-block">
					      <textarea class="layui-textarea" placeholder="一行一个" id="forbidden_port" rows="4">{$edit_user->get_forbidden_port()}</textarea>
					    </div>
					  </div>
				</div>
				</div>
			</div>
		</div>

		<div class="layui-col-md12 tac">
			<button id="edit-submit" type="submit" class="layui-btn"><i class="icon ptfont pticon-editupdatepencil"></i> 提交修改</button>
			<a class="layui-btn layui-btn-primary" href="/admin/user">返回</a>
		</div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

{include file='admin-foot.tpl'}

<script>
require(['domReady','jquery','validate'], function(domReady,$,validate){

	 domReady(function() {

		submit= function(){	

			if(document.getElementById('is_admin').checked)
			{
				var is_admin=1;
			}
			else
			{
				var is_admin=0;
			}

			if(document.getElementById('enable').checked)
			{
				var enable=1;
			}
			else
			{
				var enable=0;
			}

			if(document.getElementById('ga_enable').checked)
			{
				var ga_enable=1;
			}
			else
			{
				var ga_enable=0;
			}

            $.ajax({
                type: "PUT",
                url: "/admin/user/{$edit_user->id}",
                dataType: "json",
                data: {
                    email: $("#email").val(),
                    remark: $("#remark").val(),
                    pass: $("#pass").val(),
										auto_reset_day: $("#auto_reset_day").val(),
                    auto_reset_bandwidth: $("#auto_reset_bandwidth").val(),
                    is_multi_user: $("#is_multi_user").val(),
                    port: $("#port").val(),
										group: $("#group").val(),
                    passwd: $("#passwd").val(),
                    transfer_enable: $("#transfer_enable").val(),
                    invite_num: $("#invite_num").val(),
										node_speedlimit: $("#node_speedlimit").val(),
                    method: $("#method").val(),
										remark: $("#remark").val(),
										money: $("#money").val(),
                    enable: enable,
                    is_admin: is_admin,
										ga_enable: ga_enable,
                    ref_by: $("#ref_by").val(),
                    forbidden_ip: $("#forbidden_ip").val(),
                    forbidden_port: $("#forbidden_port").val(),
										class: $("#class").val(),
										class_expire: $("#class_expire").val(),
										expire_in: $("#expire_in").val(),
										node_connector: $("#node_connector").val(),
										protocol: $("#protocol").val(),
										protocol_param: $("#protocol_param").val(),
										obfs: $("#obfs").val(),
										obfs_param: $("#obfs_param").val()
                },
                success: function (data) {
                    if (data.ret) {
                    	{literal}
                        layer.msg(data.msg, {icon: 6});{/literal}
                        window.setTimeout("location.href=top.document.referrer",1800);
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
					layer.msg("发生错误："+jqXHR.status);
					//layer.msg(data.msg+"  发生了错误。");
                }
            });
        }

        $("html").keydown(function (event) {
            if (event.keyCode == 13) {
                submit();
            }
        });

        $("#edit-submit").click(function () {
            submit();
        });

     })
})
</script>

