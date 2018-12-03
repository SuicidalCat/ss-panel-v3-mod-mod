{include file='theme-head.tpl'}
<body>

<div id="theme-page" class="layui-container node-info">
	<!--content-->
	<div class="layui-row layui-col-space20">
	<div class="layui-col-md12">

	<h1 class="site-h1">节点详情：{$prefix}</h1>

	{$load=$point_node->getNodeLoad()}
	<!--content-->
	<div class="layui-row layui-col-space20">

		<div class="layui-col-md6">
			<div class="layui-card">
		        <div class="layui-card-header">节点在线率</div>
		        <div class="layui-card-body">
		        	<canvas id="chart-node-up{$id}"></canvas>
		        </div>
		     </div>
		</div>

		<div class="layui-col-md6">
			<div class="layui-card">
		        <div class="layui-card-header">节点负载</div>
		        <div class="layui-card-body">
		        	<canvas id="chart-node-load{$id}"></canvas>
		        </div>
		     </div>
		</div>

		<div class="layui-col-md6">
			<div class="layui-card">
		        <div class="layui-card-header">节点使用人数</div>
		        <div class="layui-card-body">
		        	<canvas id="chart-node-online{$id}"></canvas>
		        </div>
		     </div>
		</div>

		<div class="layui-col-md6">
			<div class="layui-card">
		        <div class="layui-card-header">节点延时</div>
		        <div class="layui-card-body">
		        	<canvas id="chart-node-ping{$id}"></canvas>
		        </div>
		     </div>
		</div>

		<div class="layui-col-md12">
			<div class="layui-card">
		        <div class="layui-card-header">节点测速</div>
		        <div class="layui-card-body">
		        	<canvas id="chart-node-speed{$id}"></canvas>
		        </div>
		     </div>
		</div>

	</div>

</div>
</div>
</div>

{include file='theme-foot.tpl'}

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

     //up
    var chartNodeUp{$id} = {
      type: 'doughnut',
      data: {
        datasets: [{
          data: [
            {$point_node->getNodeUpRate()*100},         
            {(1-$point_node->getNodeUpRate())*100}
          ],
          backgroundColor: [
            window.chartColors.green,
            window.chartColors.gray
          ],
          borderWidth:ChartBorder
        }],
        labels: [
          '在线率 {number_format($point_node->getNodeUpRate()*100)}%',
          '离线率 {number_format((1-$point_node->getNodeUpRate())*100)}%'
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
              return data['labels'][tooltipItem['index']];
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
                text:{number_format($point_node->getNodeUpRate()*100)}+'%',
                fontColor: window.chartColors.green,
                fontFamily: "'Helvetica Neue', 'Helvetica', 'Arial', sans-serif",
                fontStyle: 'normal',
                minFontSize: 1,
                maxFontSize: 50
            }
          }
      }
    };

    //load
	var chartNodeLoad{$id} = {
		type: 'line',
		data: {
			datasets: [{
				label: '流量(Gb)',
				backgroundColor: window.chartColors.green,
				fill: false,
				data: [
					{$i=0}
						{foreach $load as $single_load}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->getNodeLoad()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->getNodeLoad()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				],
			}]
		},
		options: {
			responsive: true,
			legend: {
	            labels: {
	                fontSize:ChartFontSize,
	                boxWidth:ChartDefaultSize
	            },
	            position: 'bottom'
	        },
			scales: {
				xAxes: [{
					type: 'time'
				}],
				yAxes: [{
					
				}]
			},
		}
	}


	//up
	{$load1=$point_node->getNodeAlive()}
	var chartNodeOnline{$id} = {
		type: 'line',
		data: {
			datasets: [{
				borderWidth:1,
				borderCapStyle:'round',
				label: '人数(个)',
				backgroundColor: window.chartColors.orange,
				fill: false,
				data: [
					{$i=0}
						{foreach $load1 as $single_load}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->online_user}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->online_user}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			}]
		},
		options: {
			responsive: true,
			legend: {
	            labels: {
	                fontSize:ChartFontSize,
	                boxWidth:ChartDefaultSize
	            },
	            position: 'bottom'
	        },
			scales: {
				xAxes: [{
					type: 'time'
				}],
				yAxes: [{
					type: 'linear'
				}]
			},
		}
	}

	//ping
	{$speedtests=$point_node->getSpeedtestResult()}
	var chartNodePing{$id} = {
		type: 'line',
		data: {
			datasets: [{
				borderWidth:1,
				borderCapStyle:'round',
				label: '电信延时',
				backgroundColor: window.chartColors.green,
				fill: false,
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomPing()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomPing()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			},

			{
				borderWidth:1,
				borderCapStyle:'round',
				label: '联通延时',
				backgroundColor: window.chartColors.orange,
				fill: false,
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomPing()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomPing()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			},

			{
				borderWidth:1,
				borderCapStyle:'round',
				label: '移动延时',
				backgroundColor: window.chartColors.blue,
				fill: false,
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccPing()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccPing()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			}
		]
		},
		options: {
			responsive: true,
			legend: {
	            labels: {
	                fontSize:ChartFontSize,
	                boxWidth:ChartDefaultSize
	            },
	            position: 'bottom'
	        },
			scales: {
				xAxes: [{
					type: 'time'
				}],
				yAxes: [{
					
				}]
			},
		}
	}


	//speed
	var chartNodeSpeed{$id} = {
		type: 'line',
		data: {
			datasets: [{
				borderWidth:1,
				borderCapStyle:'round',
				label: '电信下载',
				backgroundColor: window.chartColors.blue,
				borderColor: window.chartColors.blue,
				fill: false,
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomUpload()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomUpload()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			},

			{
				borderWidth:2,				
				label: '电信上传',
				pointStyle:'rectRot',
				backgroundColor: window.chartColors.white,
				borderColor: window.chartColors.blue,
				fill: false,
				borderDash: [5, 5],
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomDownload()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomDownload()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			},

			{
				borderWidth:1,
				borderCapStyle:'round',
				label: '联通下载',
				backgroundColor: window.chartColors.purple,
				borderColor: window.chartColors.purple,
				fill: false,
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomUpload()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomUpload()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			},
			{
				borderWidth:2,
				label: '联通上传',
				pointStyle:'rectRot',
				backgroundColor: window.chartColors.white,
				borderColor: window.chartColors.purple,
				fill: false,
				borderDash: [5, 5],
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomDownload()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomDownload()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			},			
			{
				borderWidth:1,
				borderCapStyle:'round',
				label: '移动下载',
				backgroundColor: window.chartColors.green,
				borderColor: window.chartColors.green,
				fill: false,
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccUpload()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccUpload()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			},
			{
				borderWidth:2,
				label: '移动上传',
				pointStyle:'rectRot',
				backgroundColor: window.chartColors.white,
				borderColor: window.chartColors.green,
				fill: false,
				borderDash: [5, 5],
				data: [
					{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccDownload()}
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccDownload()}
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
				]
			}

			]
		},
		options: {
			responsive: true,
			maintainAspectRatio: false,
			legend: {
	            labels: {
	                fontSize:ChartFontSize,
	                boxWidth:ChartDefaultSize
	            },
	            position: 'bottom'
	        },
			scales: {
				xAxes: [{
					type: 'time'
				}],
				yAxes: [{
					
				}]
			},
		}
	}

	

    //
    domReady(function(){

      var ctx = document.getElementById('chart-node-load{$id}').getContext('2d');
      window.myPie = new Chart(ctx,chartNodeLoad{$id});

      var ctx1 = document.getElementById('chart-node-online{$id}').getContext('2d');
      window.myPie1 = new Chart(ctx1,chartNodeOnline{$id});

      var ctx2 = document.getElementById('chart-node-ping{$id}').getContext('2d');
      window.myPie2 = new Chart(ctx2,chartNodePing{$id});

      var ctx3 = document.getElementById('chart-node-speed{$id}').getContext('2d');
      window.myPie3 = new Chart(ctx3,chartNodeSpeed{$id});

      var ctx4 = document.getElementById('chart-node-up{$id}').getContext('2d');
      window.myPie4 = new Chart(ctx4,chartNodeUp{$id});
            
    })
    //chart end
})
</script>