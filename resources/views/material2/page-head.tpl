<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>{$config["appName"]}</title>
  <link rel="icon" type="image/png" href="/theme/sp/assets/img/favicon-32x32.png" sizes="32x32" />
  <link rel="icon" type="image/png" href="/theme/sp/assets/img/favicon-16x16.png" sizes="16x16" />
  <!--[if lt IE 9]>
  <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
  <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->
  <link href="/theme/sp/assets/css/icon.css" rel="stylesheet">
  <link href="/theme/sp/assets/css/spui.css" rel="stylesheet">
</head>
<body class="layui-layout-body">

<div class="layui-layout layui-layout-admin theme-page">

  {include file='head-nav.tpl'}

  <div class="layui-side layui-side-menu" id="side-menu">
    <div class="layui-side-scroll">

      <div class="layui-logo logo">
        <a href="/user/"><img src="https://cdn.jsdelivr.net/gh/SuicidalCat/ss-panel-v3-mod-mod@v1.2.0.10/public/images/walllink_logo_black_small.png" height="35">{$config["appName"]}</a>
      </div>

      <ul class="layui-nav layui-nav-tree" lay-filter="theme-page-menu">
        
        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">站點</a>
          <dl class="layui-nav-child">  
            <dd class="layui-nav-item"><a href="/user/"><i class="icon ptfont pticon-househomeshelter"></i>面板首頁</a></dd>
            <dd class="layui-nav-item"><a href="/user/announcement"><i class="icon ptfont pticon-shoutoutspeaker"></i>系統公告</a></dd>
          </dl>
        </li>

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">购买</a>
          <dl class="layui-nav-child">  
            <dd class="layui-nav-item"><a href="/user/code"><i class="icon ptfont pticon-dollarcurrencymo"></i>賬戶儲值</a></dd>
            <dd class="layui-nav-item"><a href="/user/shop"><i class="icon ptfont pticon-carte-commercesh"></i>資源包購買</a></dd>
            <dd class="layui-nav-item"><a href="/user/node"><i class="icon ptfont pticon-locationpinmap1"></i>接入點使用</a></dd>
          </dl>
        </li>

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">服务</a>
          <dl class="layui-nav-child">
            <dd class="layui-nav-item"><a href="/user/bought"><i class="icon ptfont pticon-billslipinvoice"></i>訂購記錄</a></dd>
            <dd class="layui-nav-item"><a href="/user/trafficlog"><i class="icon ptfont pticon-graphstatsanalyt"></i>流量歷史</a></dd>
          </dl>
        </li>
        
        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">雜項</a>
          <dl class="layui-nav-child">              
            <dd class="layui-nav-item"><a href="/user/detect/log"><i class="icon ptfont pticon-sortfilterarrang"></i>鏈接審計</a></dd>
            <dd class="layui-nav-item"><a href="/user/relay"><i class="icon ptfont pticon-circuitnetworkpa"></i>流量中轉</a></dd>
            <dd class="layui-nav-item"><a href="//docs.walllink.io" target="_blank"><i class="icon ptfont pticon-listnotesalign"></i>技術文檔</a></dd>
          </dl>
        </li>
        
        {if $user->isAdmin()}
        <hr>
        <li class="layui-nav-item manage"><a href="/admin"><i class="icon ptfont pticon-gearcogsetupup"></i>管理</a></li>
        {/if}
      </ul>
    </div>

  </div>