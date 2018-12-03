{include file='page-head.tpl'}

<div class="layui-body user-edit">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<h1 class="site-h1">登录记录</h1>

  <div class="layui-card">
    <div class="layui-tab layui-tab-brief">
        <ul class="layui-tab-title">
          <li><a href="/user/edit">个人中心</a></li>
          <li><a href="/user/invite">邀请码</a></li>
          <li class="layui-this">登录记录</li>
        </ul>
    </div>
  </div>

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md12">

          <div class="layui-card">
            <div class="layui-card-header">最近登录IP</div>
            <div class="layui-card-body">
              <div class="table-over">
               <table class="layui-table">
                <colgroup>
                  <col width="100">
                  <col>
                </colgroup>
                <thead>
                    <th>IP</th>
                    <th>归属地  (* 如有异常,修改密码)</th>
                </thead>
                <tbody> 
                    {foreach $userloginip as $single=>$location}
                        <tr>
                            <td>{$single}</td>
                            <td>{$location}</td>
                        </tr>
                    {/foreach}
                </tbody>
              </table>
            </div>
            </div>
          </div>

        </div>


    <div class="layui-col-md12 text-center">{$smarty.now|date_format:"%Y"} &copy; {$config["appName"]} <a href="/staff" target="_blank">Staff</a>  / Theme By <a href="https://t.me/serikang" target="_blank">Sp</a></div>
	<!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}