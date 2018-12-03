{include file='admin-head.tpl'}

<div class="layui-body admin-index">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

    <!--title-->
    <h1 class="site-h1">控制台</h1>

    <div class="layui-row layui-col-space20" style="margin-bottom:10px">

      <div class="layui-col-md6">
        <div class="layui-card" id="quick-url">
          <div class="layui-card-header">快捷方式</div>
          <div class="layui-card-body" style="min-height:94px">
            <ul class="layui-row layui-col-space20">
              <li class="layui-col-md3 layui-col-xs6">
                <a href="/admin/node/create"><i class="icon ptfont pticon-locationpinmap1"></i> <span>添加节点</span></a>
              </li>
              <li class="layui-col-md3 layui-col-xs6">
                <a href="/admin/shop/create"><i class="icon ptfont pticon-bucketdroppaint"></i> <span>添加套餐</span></a>
              </li>
              <li class="layui-col-md3 layui-col-xs6">
                <a href="/admin/announcement"><i class="icon ptfont pticon-mailboxboxletter"></i> <span>公告管理</span></a>
              </li>
              <li class="layui-col-md3 layui-col-xs6">
                <a href="/admin/bought"><i class="icon ptfont pticon-billslipinvoice"></i> <span>购买记录</span></a>
              </li>
            </ul>
          </div>
        </div>
      </div>

      <div class="layui-col-md6">
        <div class="layui-card">
          <div class="layui-card-header">系统简报</div>
          <div class="layui-card-body layadmin-backlog">
            <ul class="layui-row layui-col-space20">
              <li class="layui-col-md3 layui-col-xs6">
                <a href="javascript:void()" class="layadmin-backlog-body">
                  <h3>今天在线人数</h3>
                  <p><cite>{($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))}</cite></p>
                </a>
              </li>
              <li class="layui-col-md3 layui-col-xs6">
                <a href="javascript:void()" class="layadmin-backlog-body">
                  <h3>今天签到人数</h3>
                  <p><cite>{$sts->getTodayCheckinUser()}</cite></p>
                </a>
              </li>
              <li class="layui-col-md6 layui-col-xs12">
                <a href="javascript:void()" class="layadmin-backlog-body">
                  <h3>今天已用流量</h3>
                  <p><cite>{(($sts->getTodayTrafficUsage()))}</cite></p>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>

    </div>

    <h1 class="site-h1">系统概况</h1>

    <!--content-->
    <div class="layui-row layui-col-space20">

        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">用户在线率<div class="layui-layout-right sub">所有用户：{$sts->getTotalUser()}人</div></div>
                <div class="layui-card-body">
                  <canvas id="chart-useronline"></canvas>
                </div>
            </div>
        </div>

        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">用户签到率<div class="layui-layout-right sub">所有用户：{$sts->getTotalUser()}人</div></div>
                <div class="layui-card-body">
                  <canvas id="chart-user"></canvas>
                </div>
            </div>
        </div>
      
        <!---->
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">流量使用率<div class="layui-layout-right sub">总分配流量：{$sts->getTotalTraffic()}</div></div>
                <div class="layui-card-body">
                  <canvas id="chart-traffic"></canvas>
                </div>
            </div>
        </div>

        
        <div class="layui-col-md6">
            <div class="layui-card">
                <div class="layui-card-header">节点情况<div class="layui-layout-right sub">所有节点：{$sts->getTotalNodes()}个</div></div>
                <div class="layui-card-body">                  
                  <canvas id="chart-node"></canvas>                  
                </div>
            </div>
        </div>


        <div class="layui-col-md12 text-center">{$smarty.now|date_format:"%Y"} &copy; {$config["appName"]} <a href="/staff" target="_blank">Staff</a>  / Theme By <a href="https://t.me/serikang" target="_blank">Sp</a></div>

    </div>
    <!--content:end-->    

</div>
</div>
</div>

{include file='admin-foot.tpl'}

<script>
require(['chartjs','domReady','rounds'], function(Chart,domReady){

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

    //user
    var pieUser = {
      type: 'doughnut',      
      data: {
        datasets: [{
          data:[
            {$sts->getTodayCheckinUser()/$sts->getTotalUser()*100},
            {(($sts->getCheckinUser()-$sts->getTodayCheckinUser())/$sts->getTotalUser())*100},
            {(1-($sts->getCheckinUser()/$sts->getTotalUser()))*100}
          ],
          backgroundColor: [
            window.chartColors.orange,
            window.chartColors.green,
            window.chartColors.gray
          ],
          borderWidth:ChartBorder
        }],        
        labels: [         
          '今日签到 {$sts->getTodayCheckinUser()}人',
          '曾经签到 {$sts->getCheckinUser()-$sts->getTodayCheckinUser()}人',
          '从未签到 {$sts->getTotalUser()-$sts->getCheckinUser()}人'
        ]
      },
      options:{
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
                text: {number_format($sts->getTodayCheckinUser()/$sts->getTotalUser()*100)}+'%',
                fontColor: window.chartColors.orange,
                fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
                fontStyle: 'normal',
                minFontSize: 1,
                maxFontSize: 50,
            }
          }
      }
    };

    //user online
    var pieUserOnline = {
      type: 'doughnut',
      data: {
        datasets: [{
          data: [
            {($sts->getOnlineUser(60))/$sts->getTotalUser()*100},
            {($sts->getOnlineUser(3600)-$sts->getOnlineUser(60))/$sts->getTotalUser()*100},
            {($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))/$sts->getTotalUser()*100},
            {(($sts->getTotalUser()-$sts->getOnlineUser(86400)-$sts->getUnusedUser())/$sts->getTotalUser())*100},
            {(($sts->getUnusedUser()/$sts->getTotalUser()))*100}
          ],
          backgroundColor: [
            window.chartColors.red,
            window.chartColors.orange,
            window.chartColors.green,
            window.chartColors.blue,
            window.chartColors.gray
          ],
          borderWidth:ChartBorder
        }],
        labels: [
          '当前在线 {($sts->getOnlineUser(60))}人',          
          '60分钟在线 {($sts->getOnlineUser(3600)-$sts->getOnlineUser(60))}人',          
          '24小时在线 {($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))}人',
          '曾经在线 {($sts->getTotalUser()-$sts->getOnlineUser(86400)-$sts->getUnusedUser())}人',
          '从未在线 {(($sts->getUnusedUser()))}人'
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
                text: {number_format(($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))/$sts->getTotalUser()*100)}+'%',
                fontColor: window.chartColors.green,
                fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
                fontStyle: 'normal',
                minFontSize: 1,
                maxFontSize: 50,
            }
          }
      }
    };

    //traffic
    var pieTraffic = {
      type: 'doughnut',
      data: {
        datasets: [{
          data: [
            {number_format((($sts->getRawTodayTrafficUsage()/$sts->getRawTotalTraffic()))*100)},         
            {number_format((($sts->getRawLastTrafficUsage()/$sts->getRawTotalTraffic()))*100)},
            {number_format((($sts->getRawUnusedTrafficUsage()/$sts->getRawTotalTraffic()))*100)}
          ],
          backgroundColor: [
            window.chartColors.orange,
            window.chartColors.green,
            window.chartColors.gray
          ],
          borderWidth:ChartBorder
        }],
        labels: [
          '今日使用 {(($sts->getTodayTrafficUsage()))}',          
          '已经使用 {(($sts->getLastTrafficUsage()))}',
          '剩余流量 {(($sts->getUnusedTrafficUsage()))}'
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
                text:{number_format((($sts->getRawLastTrafficUsage()/$sts->getRawTotalTraffic()))*100)}+'%',
                fontColor: window.chartColors.green,
                fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
                fontStyle: 'normal',
                minFontSize: 1,
                maxFontSize: 50
            }
          }
      }
    };

    //node
    var pieNode = {
      type: 'doughnut',
      data: {
        datasets: [{
          {if $sts->getTotalNodes()!=0}
          data: [
            {number_format((($sts->getAliveNodes()/$sts->getTotalNodes()))*100)},         
            {number_format((1-($sts->getAliveNodes()/$sts->getTotalNodes()))*100)}
          ],
          {/if}
          backgroundColor: [
            window.chartColors.orange,
            window.chartColors.gray,
          ],
          borderWidth:ChartBorder
        }],
        labels: [
          '在线节点 {$sts->getAliveNodes()}个',          
          '离线节点 {$sts->getTotalNodes()-$sts->getAliveNodes()}个'
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
              var percent =
                [
                  '{number_format((($sts->getAliveNodes()/$sts->getTotalNodes()))*100)}%',
                  '{number_format((1-($sts->getAliveNodes()/$sts->getTotalNodes()))*100)}%'
                ]
              return data['labels'][tooltipItem['index']] + percent[tooltipItem['index']];
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
                //maxText: '100%',
                text:{$sts->getTotalNodes()}+'个',
                fontColor: window.chartColors.orange,
                fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
                fontStyle: 'normal',
                minFontSize: 1,
                maxFontSize: 30
            }
          }

      }
    }; 

    //
    domReady(function(){
      
      
      var ctx4 = document.getElementById('chart-traffic').getContext('2d');
      window.myPie = new Chart(ctx4,pieTraffic);
      
      var ctx1 = document.getElementById('chart-node').getContext('2d')
      window.myPie1 = new Chart(ctx1, pieNode);
      

      var ctx2 = document.getElementById('chart-useronline').getContext('2d')
      window.myPie2 = new Chart(ctx2, pieUserOnline);

      var ctx3 = document.getElementById('chart-user').getContext('2d')
      window.myPie3 = new Chart(ctx3, pieUser);

    });

})
</script>