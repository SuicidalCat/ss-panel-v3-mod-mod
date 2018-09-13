{$load=$point_node->getNodeLoad()}

<div id="load{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="up{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="alive{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="speedtest{$id}_chart" style="height: 300px; width: 100%;"></div>
	<div id="speedtest{$id}_ping_chart" style="height: 300px; width: 100%;"></div>				
	<script type="text/javascript">
		$().ready(function(){
			chart{$id} = new CanvasJS.Chart("load{$id}_chart",
			{
				title:{
					text: "接入點負載統計 {$prefix}"
				},
				data: [
				{
					type: "line", 
					dataPoints: [
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
						
					]
				}
				]
			});									
			up_chart{$id} = new CanvasJS.Chart("up{$id}_chart",
			{
				title:{
					text: "接入點uptime統計 {$prefix} - 在线 {$point_node->getNodeUptime()}"
				},
				data: [
					{
						//startAngle: 45,
						indexLabelFontSize: 20,
						indexLabelFontFamily: "Garamond",
						indexLabelFontColor: "darkgrey",
						indexLabelLineColor: "darkgrey",
                        yValueFormatString: "##0.00\"%\"",
						indexLabelPlacement: "outside",
						type: "doughnut",
						showInLegend: true,
						dataPoints: [
							{
								y: {$point_node->getNodeUpRate()*100}, label: "在线率",legendText:"在线率 {number_format($point_node->getNodeUpRate()*100,2)}%", indexLabel: "在线率 {number_format($point_node->getNodeUpRate()*100,2)}%"
							},
							{
								y: {(1-$point_node->getNodeUpRate())*100}, label: "离线率",legendText:"离线率 {number_format((1-$point_node->getNodeUpRate())*100,2)}%", indexLabel: "离线率 {number_format((1-$point_node->getNodeUpRate())*100,2)}%"
							}
						]
					}
					]
			});			
			{$load=$point_node->getNodeAlive()}
			alive_chart{$id} = new CanvasJS.Chart("alive{$id}_chart",
			{
				title:{
					text: "接入點鏈接數統計 {$prefix}"
				},
				data: [
				{
					type: "line", 
                  yValueFormatString: "##0\"人\"",
					dataPoints: [
						{$i=0}
						{foreach $load as $single_load}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->online_user},label: "同时在线人数"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_load->log_time*1000}), y:{$single_load->online_user},label: "同时在线人数"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				}
				]
			});									
			{$speedtests=$point_node->getSpeedtestResult()}
			speedtest_chart{$id} = new CanvasJS.Chart("speedtest{$id}_chart",
			{
				title:{
					text: "接入點延遲統計 {$prefix}"
				},
				axisY: {				
					suffix: " ms"
				},
				data: [
				{
					type: "line", 
					showInLegend: true,
					legendText: "CT",
                    yValueFormatString: "##0\"ms\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomPing()},label: "CT"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomPing()},label: "CT"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				},
				{
					type: "line", 
					showInLegend: true,
					legendText: "CU",
                  yValueFormatString: "##0\"ms\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomPing()},label: "CU"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomPing()},label: "CU"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				},
				{
					type: "line", 
					showInLegend: true,
					legendText:"CM",
                  yValueFormatString: "##0\"ms\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccPing()},label: "CM"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccPing()},label: "CM"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				}
				]
			});			
			speedtest_ping_chart{$id} = new CanvasJS.Chart("speedtest{$id}_ping_chart",
			{
				title:{
					text: "接入點速率統計 {$prefix}"
				},
				axisY: {
					includeZero: false,
					suffix: " Mbps"
					},
              	toolTip:{
	     			shared: true
	                   },
				data: [
				{
					type: "line", 
					showInLegend: true,
					legendText: "CT下載",
                  	name: "CT下載",
                  yValueFormatString: "##0.00\"Mb\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomDownload()},label: "CT下載"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomDownload()},label: "CT下載"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				},
				{
					type: "line", 
					showInLegend: true,
					legendText: "CT上傳",
                  name: "CT上傳",
                  yValueFormatString: "##0.00\"Mb\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomUpload()},label: "CT上傳"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getTelecomUpload()},label: "CT上傳"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				},
				{
					type: "line", 
					showInLegend: true,
					legendText: "CU下載",
                  name: "CU下載",
                  yValueFormatString: "##0.00\"Mb\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomDownload()},label: "CU下載"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomDownload()},label: "CU下載"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				},
				{
					type: "line", 
					showInLegend: true,
					legendText: "CU上傳",
                  name: "CU上傳",
                  yValueFormatString: "##0.00\"Mb\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomUpload()},label: "CU上傳"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getUnicomUpload()},label: "CU上傳"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				},				
				{
					type: "line", 
					showInLegend: true,
					legendText:"CM下載",
                  name: "CM下載",
                  yValueFormatString: "##0.00\"Mb\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccDownload()},label: "CM下載"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccDownload()},label: "CM下載"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				},
				{
					type: "line", 
					showInLegend: true,
					legendText:"CM上傳",
                  name: "CM上傳",
                  yValueFormatString: "##0.00\"Mb\"",
					dataPoints: [
						{$i=0}
						{foreach $speedtests as $single_speedtest}
							{if $i==0}
								{literal}
								{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccUpload()},label: "CM上傳"
								{literal}
								}
								{/literal}
								{$i=1}
							{else}
								{literal}
								,{
								{/literal}
									x: new Date({$single_speedtest->datetime*1000}), y:{$single_speedtest->getCmccUpload()},label: "CM上傳"
								{literal}
								}
								{/literal}
							{/if}
						{/foreach}
						
					]
				}
				]
			});								
			chart{$id}.render();
			up_chart{$id}.render();
			alive_chart{$id}.render();
			speedtest_chart{$id}.render();
			speedtest_ping_chart{$id}.render();		
		});			
	</script>