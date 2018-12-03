{include file='theme-head.tpl'}
<body>
{$ssr_prefer = URL::SSRCanConnect($user, $mu)}
<div id="theme-page" class="layui-container node-info">

	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md8 layui-col-md-offset2">

        <h1 class="site-h1">节点使用：{$node->name} <span>注意！配置文件以及二维码请勿泄露！</span></h1>

        <div class="layui-card">
        	<div class="layui-card-header">节点二维码</div>
          <div class="layui-card-body">
  				{if URL::SSRCanConnect($user, $mu)}
  					<div class="text-center">
  						<div id="ssr-qr"></div>
  					</div>
  				{else}
  					<p>亲目前的 加密方式/混淆/协议设置无法连接。请修改之后再连接。（单端口多用户的连接不受影响）</p>
  				{/if}
	        </div>
        </div>

        <div class="layui-card">
          <div class="layui-card-header">配置链接</div>
          <div class="layui-card-body">
            {if URL::SSRCanConnect($user, $mu)}
            {$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
              <p>
                <a class="layui-btn layui-btn-sm copy-btn layui-btn-primary" data-clipboard-text="{URL::getItemUrl($ssr_item, 0)}">点击复制</a>
                 添加到小飞机工具里即可
              </p>
            {else}
              <p>您好，您目前的 加密方式，混淆，或者协议设置在 ShadowsocksR 客户端下无法连接。请您选用 Shadowsocks 客户端来连接，或者到 资料编辑 页面修改后再来查看此处。</p>
            {/if}
          </div>
        </div>

        <div class="layui-card">
        	<div class="layui-card-header">若扫失败，请手动填写以下配置</div>
          <div class="layui-card-body">
  				{if URL::SSRCanConnect($user, $mu)}
  					{$ssr_item = URL::getItem($user, $node, $mu, $relay_rule_id, 0)}
  					<table class="layui-table">
              <colgroup>
                <col width="100">
                <col>
              </colgroup>
              <tbody>
               <tr>
                  <td>节点地址</td>
                  <td>{$ssr_item['address']}</td>
                </tr>             
                <tr>
                  <td>端口</td>
                  <td>{$ssr_item['port']}</td>
                </tr>
                 <tr>
                  <td>连接密码</td>
                  <td>{$ssr_item['passwd']}</td>
                </tr>
                <tr>
                  <td>加密方式</td>
                  <td>{$ssr_item['method']}</td>
                </tr>
                <tr>
                  <td>协议</td>
                  <td>{$ssr_item['protocol']}</td>
                </tr>
                <tr>
                  <td>协议参数</td>
                  <td>{$ssr_item['protocol_param']}</td>
                </tr>
                <tr>
                  <td>混淆</td>
                  <td>{$ssr_item['obfs']}</td>
                </tr>
                <tr>
                  <td>混淆参数</td>
                  <td>{$ssr_item['obfs_param']}</td>
                </tr>
              </tbody>
            </table>
  				{else}
  					<p>亲目前的 加密方式/混淆/协议设置无法连接。请修改之后再连接。（单端口多用户的连接不受影响）</p>
            <p>并且，在当前状态下您的 SSR 订阅链接已经失效，您无法通过此种方式导入节点。</p>
  				{/if}
	        </div>
	      </div>       

    </div>
	<!--content:end-->

</div>

{include file='theme-foot.tpl'}

{if URL::SSRCanConnect($user, $mu)}
<script>
require(['qrcode'], function(){
	var qrcode = new QRCode(document.getElementById("ssr-qr"),{
		text:"{URL::getItemUrl($ssr_item, 0)}",
		width: 200,
		height: 200
	});
})
</script>
{/if}