{include file='page-head.tpl'}
{$ssr_prefer = URL::SSRCanConnect($user, 0)}
<div class="layui-body user-index">
    <div class="layadmin-tabsbody-item layui-show">
        <div class="layui-container">
            <!--title-->
            <h1 class="site-h1">首页</h1>
            <!--content-->
            <div class="layui-row layui-col-space20">                

                <div class="layui-col-md8">

                    <div class="layui-row layui-col-space20">

                        <div class="layui-col-md12">
                            <div class="layui-row user-info">
                                <div class="layui-col-md7 layui-col-sm6">
                                    <div class="user-info-bd fix">
                                        {if !$user->gravatar}                                            
                                            <img class="avatar-icon" src="/theme/sp/assets/img/Avatar.jpg">
                                        {else}
                                            <img class="avatar-icon" src="{$user->gravatar}">
                                        {/if}
                                        <h4>
                                            {if !$user->user_name}{$user->email}{else}{$user->user_name}{/if}
                                            <span class="layui-badge">Lv.{$user->class}</span>
                                        </h4>
                                        <p>
                                            <a href="/user/edit" class="layui-btn layui-btn-primary layui-btn-xs">个人中心</a>
                                            <a href="/user/invite" class="layui-btn layui-btn-primary layui-btn-xs">邀请码</a>
                                        </p>
                                    </div>
                                </div>
                                <div class="layui-col-md5 layui-col-sm6">
                                    <div class="user-info-ft">
                                        <p>
                                            {$nodeNow=$smarty.now|date_format:'%Y-%m-%d'}
                                            {$nodeYear=$user->class_expire|date_format:'%Y-%m-%d'}
                                            {if $nodeNow > $nodeYear || $user->transfer_enable-($user->u+$user->d) == 0 }
                                                <i class="icon ptfont pticon-cautionalerttria"></i> 尚未购买
                                            {else}
                                                套餐截止{$user->class_expire|date_format:'%Y-%m-%d'}
                                            {/if}
                                            &nbsp;&nbsp;<a href="/user/shop" class="layui-btn layui-btn-sm">续费</a>
                                        </p>
                                        <p>速度限制：
                                            {if $user->node_speedlimit!=0}
                                                {$user->node_speedlimit}Mbps
                                            {else}
                                                不限速
                                            {/if}
                                        </p>
                                        <p>设备限制：
                                            {if $user->node_connector!=0}
                                                允许{$user->node_connector}个设备使用
                                            {else}
                                                不限制 (当前{$user->online_ip_count()}个在线)
                                            {/if}
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>                        

                        <div class="layui-col-md12">
                            <div class="layui-card">
                                <div class="layui-card-header">购买流程
                                    <div class="layui-layout-right">
                                        <a href="/user/code" class="layui-btn layui-btn-sm">账户充值</a> 
                                        <a href="/user/shop" class="layui-btn layui-btn-sm">购买套餐</a> 
                                        <a href="/user/node" class="layui-btn layui-btn-sm">节点使用</a>
                                    </div>
                                </div>
                                <div class="layui-card-body">
                                    <p>严禁BT迅雷下载及非法活动，一经发现有权在不通知的情况下进行封号！</p>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md5 hide">
                            <div class="layui-card">
                                <div class="layui-card-header">工单
                                    <div class="layui-layout-right"><a class="layui-btn layui-btn-primary layui-btn-sm" href="/user/ticket/create">提交工单</a> <a href="/user/ticket" class="layui-btn layui-btn-primary layui-btn-sm">查看工单</a></div>
                                </div>
                                <div class="layui-card-body">
                                    <p>处理时间：10:00 - 21:00</p>
                                    <p>如遇紧急问题，提交工单等待答复。</p>
                                </div>
                            </div>
                        </div>

                        <div class="layui-col-md12" id="page-node">
                          <div class="layui-card learn">
                            <div class="layui-card-header">使用教程 <span>适合浏览网页看视频用户</span></div>
                            <div class="layui-card-body" style="min-height:82px">
                                {include file='user/learn.tpl'}
                            </div>
                          </div>
                        </div>
                        <div class="layui-col-md12" id="user-super-tut">
                            <div class="layui-card">
                                <div class="layui-card-header">进阶教程 <span>适合技术宅游戏迷用户</span></div>
                                <div class="layui-card-body">
                                    {$pre_user = URL::cloneUser($user)}
                                    <div class="layui-tab layui-tab-brief">
                                        <ul class="layui-tab-title">
                                            <li class="layui-this"><i class="icon ptfont pticon-clipattachmentpa"></i> 订阅地址</li>
                                                               <li><i class="icon ptfont pticon-clipattachmentpa"></i> 导入节点</li>
                                                               <li><i class="icon ptfont pticon-locationpinmap2"></i> 游戏加速</li>
                                                               <li><i class="icon ptfont pticon-circuitelectricbo"></i> 路由器</li>
                                        </ul>
                                        <div class="layui-tab-content">
                                                {$user = URL::getSSRConnectInfo($pre_user)}
                                                {$ssr_url_all = URL::getAllUrl($pre_user, 0, 0)}
                                                {$ssr_url_all_mu = URL::getAllUrl($pre_user, 1, 0)}
                                            <div class="layui-tab-item layui-show">
                                                普通订阅地址：
                                                <div class="clip-input">
                                                    <input type="text" id="p_port" class="layui-input" value="{$baseUrl}/link/{$ssr_sub_token}?mu=0" readonly/>
                                                    <button class="layui-btn layui-btn-sm copy-btn layui-btn-primary" data-clipboard-target="#p_port">点击复制</button>
                                                </div>
                                                <br>
                                                单端口订阅地址：
                                                <div class="clip-input">
                                                    <input type="text" id="d_port" class="layui-input" value="{$baseUrl}/link/{$ssr_sub_token}?mu=1" readonly/>
                                                    <button class="layui-btn layui-btn-sm copy-btn layui-btn-primary" data-clipboard-target="#d_port">点击复制</button>
                                                </div>
                                                <br>
                                                <a href="javascript:void();" class="reset-link layui-btn layui-btn-sm">重置订阅链接</a>
                                            </div>
                                            <div class="layui-tab-item">
                                                从浏览器点击 <a href="{$ssr_url_all}" class="layui-btn layui-btn-primary">普通端口导入</a>
                                                <a href="{$ssr_url_all_mu}" class="layui-btn layui-btn-primary">单端口导入</a> 然后点击确定
                                            </div>
                                            <div class="layui-tab-item">
                                                <a href="/ssr-download/SSTap.7z" class="layui-btn">点击下载</a> 解压后，运行一键游戏加速
                                                <br>(1) 期间会安装虚拟网卡，请点击允许或确认
                                                <br>(2) 打开桌面程序SSTap
                                                <br>(3) 齿轮图标-SSR订阅-SSR订阅管理添加以下订阅链接即可
                                                <br>(4) 更新后选择其中一个节点闪电图标测试节点-测试UDP转发...通过!（UDP通过即可连接并开始游戏），如测试不通过，点击齿轮图标设置DNS，推荐谷歌DNS
                                                
                                                <p>
                                                普通订阅地址：
                                                <div class="clip-input">
                                                    <input type="text" id="p_port" class="layui-input" value="{$baseUrl}/link/{$ssr_sub_token}?mu=0" readonly/>
                                                    <button class="layui-btn layui-btn-sm copy-btn layui-btn-primary" data-clipboard-target="#p_port">点击复制</button>
                                                </div>
                                                <br>
                                                单端口订阅地址：
                                                <div class="clip-input">
                                                    <input type="text" id="d_port" class="layui-input" value="{$baseUrl}/link/{$ssr_sub_token}?mu=1" readonly/>
                                                    <button class="layui-btn layui-btn-sm copy-btn layui-btn-primary" data-clipboard-target="#d_port">点击复制</button>
                                                </div>
                                                </p>
                                            </div>                                  
                                            <div class="layui-tab-item">
                                                <p>
                                                    路由器 刷入<a href="http://www.right.com.cn/forum/thread-161324-1-1.html" class="layui-btn layui-btn-primary">这个固件</a> 然后SSH方式登陆路由器，执行以下命令，导入<br>
                                                    1) 普通端口
                                                    <pre class="layui-code">wget -O- {$baseUrl}/link/{$router_token}?is_ss=0 | bash && echo -e "\n0 */3 * * * wget -O- {$baseUrl}/link/{$router_token}?is_ss=0 | bash\n">> /etc/storage/cron/crontabs/admin && killall crond && crond </pre>
                                                    2) 或者 单端口
                                                    <pre class="layui-code">wget -O- {$baseUrl}/link/{$router_token_without_mu}?is_ss=0 | bash && echo -e "\n0 */3 * * * wget -O- {$baseUrl}/link/{$router_token_without_mu}?is_ss=0 | bash\n">> /etc/storage/cron/crontabs/admin && killall crond && crond </pre>
                                                    执行完毕以后就可以到路由器的设置面板里随意选择 节点 进行连接了。
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="layui-col-md4">
                    <div class="layui-row layui-col-space20">

                         <div class="layui-col-md12">
                            <div class="layui-card">
                                <div class="layui-card-header">公告
                                    <div class="layui-layout-right"><a href="/user/announcement" class="layui-btn layui-btn-primary layui-btn-sm">查看公告</a></div>
                                </div>
                                <div class="layui-card-body layui-text" style="min-height:80px">
                                    {if $ann != null}
                                        <p>{$ann->content}</p>
                                    {else}
                                        欢迎━(*｀∀´*)ノ亻!
                                    {/if}                                    
                                </div>                                
                            </div>
                        </div>                      
                        
                        <div class="layui-col-md12">
                            <div class="layui-card">
                                <div class="layui-card-header">使用情况 <span>最后使用:{$user->lastSsTime()|date_format:'%Y-%m-%d'}</span>
                                    <div class="layui-layout-right">
                                        <!--签到时验证改为false才能成功-->
                                        {if $user->isAbleToCheckin()}
                                            <p id="checkin-btn">
                                                <button id="checkin" class="layui-btn layui-btn-sm"><i class="icon ptfont pticon-giftrewardbonus"></i> 签到续命</button>
                                            </p>
                                            <button id="checked-btn" class="layui-btn layui-btn-disabled layui-btn-sm index-checked-btn">已签到</button>
                                        {else}
                                            <button class="layui-btn layui-btn-disabled layui-btn-sm index-checked-btn">已签到</button>
                                        {/if}
                                    </div> 
                                </div>
                                <div class="layui-card-body">
                                    <canvas id="chart-user-traffic" height="110"></canvas>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>

                <div class="layui-col-md12 text-center">{$smarty.now|date_format:"%Y"} &copy; {$config["appName"]} <a href="/staff" target="_blank">Staff</a>  / Theme By <a href="https://t.me/serikang" target="_blank">Sp</a></div>
            
            </div>
            <!--content:end-->
        </div>
    </div>
</div>
{include file='page-foot.tpl'}

<script>
window.sp={
    checktime : '{$user->lastCheckInTime()}',
    checkinMin: '{$config['checkinMin']}',
    checkinMax: '{$config['checkinMax']}'
};
</script>

<script>
require(['jquery','chartjs','cookie','domReady','rounds'], function($,Chart,cookie,domReady){

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

    //reset
    $(".reset-link").click(function () {
        layer.msg("重置成功！请重新添加订阅链接！");
        window.setTimeout("location.href='/user/url_reset'",1800);
    });

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
          '今日使用 {$user->TodayusedTraffic()}',
          '已经使用 {$user->LastusedTraffic()}',
          '剩余流量 {$user->unusedTraffic()}'
        ]
      },
      options: {
        responsive: true,
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
        var ctx9 = document.getElementById('chart-user-traffic').getContext('2d');
        window.myPie9 = new Chart(ctx9,pieUserTraffic);        

        //notice
        {if $nodeNow > $nodeYear || $user->transfer_enable-($user->u+$user->d) == 0 }

            layer.msg('<i class="icon ptfont pticon-cautionalerttria"></i> 尚未购买', {
              time: 0
              ,offset: 'b'
              ,id:'noticetip'
              ,anim: 2
              ,btn: ['前往购买','知道了']
              ,btnAlign: 'c'
              ,success: function(layero){
                var btn = layero.find('.layui-layer-btn');
                btn.find('.layui-layer-btn0').attr({
                  href: '/user/code'
                });
                btn.find('.layui-layer-btn1').click(function(){ 
                  $.cookie('tipdiv', 'hide', { expires: 1 });
                  console.log("close");
                })
              }              
            });

            if( $.cookie('tipdiv')=='hide'){
                $('#noticetip').parent(".layui-layer").hide()
            }

        {/if}
    })

})
</script>