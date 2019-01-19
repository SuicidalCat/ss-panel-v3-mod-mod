{include file='page-head.tpl'}
{literal}
<style>
	.v-modal-part{visibility:hidden;display: none}
	.v-modal-part.layui-layer-wrap{visibility:visible;display:block}
	.v-modal-showbg .layui-layer{background:#eee}
</style>
{/literal}

{function displayV2rayNode node=null}
{assign var=server_explode value=";"|explode:$node['server']}

	<div class="layui-row layui-col-space20">
	<div class="layui-col-md8 layui-col-md-offset2">

		<h1 class="site-h1">{$node['name']}</h1>
		<div class="layui-card">
		<div class="layui-card-body">			
			<!--v2ray-->											
			<table class="layui-table">
				<colgroup>
			      <col width="90">
			      <col>
			    </colgroup>
			    <tbody>
				<tr>
					<td>鏈接地址</td>
					<td>{$server_explode[0]}</td>
				</tr>
				<tr>
					<td>端口</td>
					<td>{$server_explode[1]}</td>
				</tr>
				<tr>
					<td>協議參數</td>
					<td>{$server_explode[2]}</td>
				</tr>
				<tr>
					<td>流量權重</td>
					<td>{$node['traffic_rate']}</td>
				</tr>
				<tr>
					<td>用户 UUID：</td>
					<td>{$user->getUuid()}</td>
				</tr>
				</tbody>
			</table>
			<section>
				<p><a class="layui-btn copy-btn" data-clipboard-text="{URL::getV2Url($user, $node['raw_node'])}">點擊複製</a></p>
			</section>
		</div>
		</div>
		<!--v2ray:end-->
	</div>
	</div>

{/function}

<div class="layui-body user-node">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<div class="layui-row layui-card" id="top-step">
		<div class="layui-col-md4 layui-col-sm4">
			<a href="/user/code"><span class="layui-badge">1</span> 賬戶儲值</a>
		</div>
		<div class="layui-col-md4 layui-col-sm4">
			<a href="/user/shop"><span class="layui-badge">2</span> 資源包購買</a>
		</div>
		<div class="layui-col-md4 layui-col-sm4 current">
			<span class="layui-badge">3</span> 接入點列表
		</div>
	</div>

	<!--title-->
	<!--h1 class="site-h1">节点使用</h1-->

	<!--content-->
	<div class="layui-row layui-col-space20" id="page-node">

		<div class="layui-col-md12">
			<div class="layui-row layui-col-space20">

				<div class="layui-col-md4">
					<div class="layui-row layui-col-space20">

						<div class="layui-col-md12">
				            <div class="layui-card">
				                <div class="layui-card-header">
				                	資源包信息
									<div class="layui-layout-right"><a href="/user/shop" class="layui-btn layui-btn-sm"><i class="icon ptfont pticon-carte-commercesh"></i> 購買</a></div>
				                </div>
				                <div class="layui-card-body">
				                    <table class="layui-table">
				                        <colgroup>
				                          <col width="90">
				                          <col>
				                        </colgroup>
				                        <tbody>           
				                          <tr>
				                            <td>到期日</td>
				                            <td>
												{$nodeNow=$smarty.now|date_format:'%Y-%m-%d'}
				                            	{$nodeYear=$user->class_expire|date_format:'%Y-%m-%d'}
				                            	{if $nodeNow > $nodeYear}
													<span class="layui-badge layui-bg-cyan">已过期</span>
				                            	{else}
													{$user->class_expire|date_format:'%Y-%m-%d'}
				                            	{/if}								
				                            </td>
				                          </tr>                                          
				                          <tr>
				                            <td>鏈接速率</td>
				                            <td>
				                                {if $user->node_speedlimit!=0}
				                                	{$user->node_speedlimit}Mbps
				                                {else}
				                                	不限
				                                {/if}
				                            </td>
				                          </tr>
				                          <tr>
				                            <td>鏈接數限制</td>
				                            <td>
				                                {if $user->node_connector!=0}
				                                    允許{$user->node_connector}個設備鏈接 ({$user->online_ip_count()}個鏈接IP)
				                                {else}
				                                    不限 ({$user->online_ip_count()}個設備在綫)
				                                {/if}
				                            </td>
				                          </tr>                                     
				                        </tbody>
				                      </table>
				                </div>
				                <div class="layui-card-body" style="height:100px">
						        	<canvas id="chart-user-traffic"></canvas>
						        </div>                              
				            </div>
				        </div>

					</div>
				</div>

				<div class="layui-col-md8">
					<div class="layui-row layui-col-space20">
						<div class="layui-col-md12">							
							<div class="layui-card">
						        <div class="layui-card-header"><i class="icon ptfont pticon-bulbthoughtidea"></i>資源包選擇</div>
						        <div class="layui-card-body">
						        	<p>接入權限1的套餐主要以歐美和日本的普通接入點爲主，適合輕量上網的用途；接入權限2的套餐開始提供韓國，新加坡，香港以及日本的優化接入點，速率與穩定性更上一層樓；接入權限3的套餐則包含了中國大陸優化接入點，適合大陸地區網絡加速與海外回大陸加速。</p>
						        </div>
						    </div>
						</div>
						<div class="layui-col-md12" id="page-node">
					      <div class="layui-card learn">
					        <div class="layui-card-header">使用指導</div>
					        <div class="layui-card-body" style="min-height:82px">
					        	{include file='user/learn.tpl'}
					        </div>
					      </div>
				        </div>
					</div>
				</div>
				
			</div>
		</div>
     
		<!--nodes-->
		<div class="layui-col-md12 nodes">
		    {$class=-1}
			{foreach $nodes as $node}
			{if $node['class']!=$class}
				{$class=$node['class']}
				{if !$node@first}</div>{/if}

				{if $class == 0}
					<!--普通-->
					<h1 class="site-h1 normal_sub"><i class="icon ptfont pticon-circuitelectricbo1"></i> 普通节点</h1>
				{else}
					<!--VIP-->
					<h1 class="site-h1 vip_sub"><i class="icon ptfont pticon-prizeawardmerit"></i> 權限{$node['class']} 接入點</h1>
				{/if}

				<!--Node-->
		    	<div class="layui-row layui-col-space20" id="cardgroup{$class}">
			{/if}

			<!--loop-->
			<div class="layui-col-md4" cardindex="{$node@index}">
		        
		        <!--node-->
				<div class="n_node {if $class == 0}normal_bg{else}vip_bg{/if}">
					<div class="n_sub">
						<h2 style="font-size:16px;font-weight: normal;">
						{if $node['online']=="1"}
							<span class="layui-badge layui-bg-green" title="正常">在綫</span>
						{elseif $node['online']=='0'}
							<span class="layui-badge layui-bg-black" title="离线">維護中</span>
						{else}
							<span class="layui-badge layui-bg-black" title="暂无数据">尚無數據</span>
						{/if}
						{if $config['enable_flag']=='true'}<img src="/images/prefix/{$node['flag']}" alt="" width="40" height="22">{/if}
							{$node['name']}
						</h2>
					</div>
					<div class="n_bd" style="min-height:160px">
						<!--Mode loop-->						

							{if $node['class'] > $user->class}
								<div class="c_node_bd text-center mustvip">
									<i class="icon ptfont pticon-viewdisablednov"></i> 訂購網路資源包即可查看 <a href="/user/shop" class="layui-btn layui-btn-sm">購買</a>
								</div>
							{else}
								{$relay_rule = null}
								<section>
                                {if $node['sort'] == 10 && $node['sort'] != 11}
								{$relay_rule = $tools->pick_out_relay_rule($node['id'], $user->port, $relay_rules)}
								{/if}

								{if $node['mu_only'] != 1 && $node['sort'] != 11}
									<!--normal-->
									<p>
							    		<a href="javascript:void(0);" class="n_btn layui-btn layui-btn-sm" data-code="code{$node['id']}" data-url="/user/node/{$node['id']}?ismu=0&relay_rule={if $relay_rule != null}{$relay_rule->id}{else}0{/if}">
					        				<span><i class="icon ptfont pticon-scanbarcodeqrc"></i></span> 鏈接信息
					        			</a>
					        		</p>
									<!--normal:end-->
							    {/if}

								{if $node['sort'] == 0 || $node['sort'] == 10}
									{$point_node=$node}
								{/if}

								{if ($node['sort'] == 0 || $node['sort'] == 10) && $node['mu_only'] != -1}
									{foreach $nodes_muport as $single_muport}

									{if !($single_muport['server']->node_class <= $user->class && ($single_muport['server']->node_group == 0 || $single_muport['server']->node_group == $user->node_group))}
									{continue}{/if}
									{if !($single_muport['user']->class >= $node['class'] && ($node['group'] == 0 || $single_muport['user']->node_group == $node['group']))}{continue}{/if}

									{$relay_rule = null}
									{if $node['sort'] == 10 && $single_muport['user']['is_multi_user'] != 2}
									{$relay_rule = $tools->pick_out_relay_rule($node['id'], $single_muport['server']->server, $relay_rules)}
									{/if}
										
									<!--single-->
									<p>
							    		<a href="javascript:void(0);" class="n_btn layui-btn layui-btn-sm" data-code="code{$node['id']}" data-url="/user/node/{$node['id']}?ismu={$single_muport['server']->server}&relay_rule={if $relay_rule != null}{$relay_rule->id}{else}0{/if}">
					        				<span><i class="icon ptfont pticon-scanbarcodeqrc"></i></span> 鏈接信息單端口
					        			</a>					        			
							    	</p>
							        <!--single:end-->

									{/foreach}
								{/if}
								</section>
								
								{if $node['sort'] == 11}
									<section>
										<p>
							    			<a href="javascript:void(0);" class="n_btn layui-btn layui-btn-sm" data-tip="{$node['id']}"><span><i class="icon ptfont pticon-scanbarcodeqrc"></i></span> 立刻接入</a>
						        		</p>
									</section>

									<div id="v-modal{$node['id']}" data-vmodal="v-modal{$node['id']}" class="v-modal-part layui-container">
										{displayV2rayNode node=$node}
									</div>									
								{/if}
									<!--not v2ray-->
									<table class="layui-table">
										<colgroup>
				                          <col width="30">
				                          <col>
				                        </colgroup>
				                        <tbody>
										<tr>
											<td><i class="icon ptfont pticon-piechartgraphs"></i></td>
											<td>{$node['traffic_rate']} 流量權重</td>
										</tr>
										<tr>
											<td><i class="icon ptfont pticon-Userpersonavtar"></i></td>
											<td>										
												{if $node['online_user'] == -1} N/A{else} {$node['online_user']}{/if}
											</td>
										</tr>
										<tr>
											<td><i class="icon ptfont pticon-piechartgraphs"></i></td>
											<td>
												{if $node['traffic_limit']>0}
													<span class="node-band">{$node['traffic_used']}/{$node['traffic_limit']}</span>
												{else}
													{$node['traffic_used']}GB
												{/if}
											</td>
										</tr>
										<tr>
											<td><i class="icon ptfont pticon-messagebubblecha"></i></td>
											<td>{$node['info']}</td>
										</tr>
										<!--节点详情-->
										{if isset($point_node) && $point_node!=null}
											<tr>
												<td><i class="icon ptfont pticon-shareexpandenlar"></i></td>
												<td>
													<a href="javascript:void(0);" title="查看详情" data-code="infoshow{$node['id']}" data-url="/user/node/{$node['id']}/ajax">接入點狀態</a>
												</td>
											</tr>
										{/if}
		                        		{$point_node=null}
		                        		<!--节点详情:end-->
										</tbody>
									</table>
									<!--not v2ray:end-->
								

							
							{/if}
					   
						<!--Mode loop:end-->
					</div>
				</div>
				<!--node:end-->

			</div>
			{$point_node=null}
			{if $node@last}</div>{/if}
			{/foreach}
		</div>
		<!--nodes:end-->

	</div>
	<!--content:end-->

</div>
</div>
</div>

<!--show-->
<div id="v-modal-show" class="v-modal-showbg">
</div>

{include file='page-foot.tpl'}
<script>
require(['jquery','chartjs','domReady','rounds'], function($,Chart,domReady){

	window.chartColors = {
      red: '#E57373',
      orange: '#FFB74D',
      green: '#81C784',
      blue: '#4FC3F7',
      gray: '#E0E0E0',
      purple: '#9575CD',
      white:'#ffffff'
    };

    ChartDefaultSize = 10;
    ChartFontSize = 14;
    ChartbodyFontSize = 14;
    ChartBorder = 3;
    ChartCutout =70;

    //traffic
    var pieUserTraffic = {
      type: 'doughnut',
      data: {
        datasets: [{
          data: [
            {number_format(($user->u+$user->d-$user->last_day_t)/$user->transfer_enable*100)},         
            {number_format($user->last_day_t/$user->transfer_enable*100)},
            {number_format(($user->transfer_enable-($user->u+$user->d))/$user->transfer_enable*100)}
          ],
          backgroundColor: [
            window.chartColors.orange,
            window.chartColors.green,
            window.chartColors.gray
          ],
          borderWidth:ChartBorder
        }],
        labels: [
          '今日已用 {$user->TodayusedTraffic()}',          
          '總計使用 {$user->LastusedTraffic()}',
          '剩餘可用 {$user->unusedTraffic()}'
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutoutPercentage:ChartCutout,
        legend: {
            labels: {
                fontSize:ChartFontSize,
                boxWidth:ChartDefaultSize
            },
            position: 'right'            
        },
        tooltips: {
          callbacks: {
            label: function(tooltipItem, data) {
              return data['labels'][tooltipItem['index']] + '(' + data['datasets'][0]['data'][tooltipItem['index']] + '%)';
            }
          },
          titleFontSize:ChartbodyFontSize,
          bodyFontSize:ChartbodyFontSize,
          xPadding:ChartDefaultSize,
          yPadding:ChartDefaultSize,
          bodySpacing:ChartDefaultSize,
          titleMarginBottom:ChartDefaultSize
        },
        elements: {
            center: {
                maxText: '100%',
                text: {number_format($user->last_day_t/$user->transfer_enable*100)}+'%',
                fontColor: window.chartColors.green,
                fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
                fontStyle: 'normal',
                minFontSize: 1,
                maxFontSize: 70,
            }
        }
      }
    };

    //
    domReady(function(){
    	var ctx = document.getElementById('chart-user-traffic').getContext('2d');
      	window.myPie = new Chart(ctx,pieUserTraffic);

      	//tips modal      	
       
	    $('a[data-tip]').on('click', function(){
	        var id = $(this).data('tip');
	        var vcontent = $('#v-modal'+id).appendTo($('#v-modal-show'))
	        
            layer.open({
              skin: 'layui-layer-demo',
              type: 1,
              title: false,
              shadeClose: true,
              shade: 0.5,
              area: ['95%', '75%'],
              content: $(vcontent)
            }); 

   		});

   		//

    })
    //chart end    

})
</script>