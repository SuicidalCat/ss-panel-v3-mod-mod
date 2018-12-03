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
        <a href="/user/"><em>Spanel</em></a>
      </div>

      <ul class="layui-nav layui-nav-tree" lay-filter="theme-page-menu">
        
        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">用户</a>
          <dl class="layui-nav-child">  
            <dd class="layui-nav-item"><a href="/user/"><i class="icon ptfont pticon-househomeshelter"></i>首页</a></dd>
            <dd class="layui-nav-item"><a href="/user/announcement"><i class="icon ptfont pticon-shoutoutspeaker"></i>公告</a></dd>
          </dl>
        </li>

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">购买</a>
          <dl class="layui-nav-child">  
            <dd class="layui-nav-item"><a href="/user/code"><i class="icon ptfont pticon-dollarcurrencymo"></i>账户充值</a></dd>
            <dd class="layui-nav-item"><a href="/user/shop"><i class="icon ptfont pticon-carte-commercesh"></i>购买套餐</a></dd>
            <dd class="layui-nav-item"><a href="/user/node"><i class="icon ptfont pticon-locationpinmap1"></i>节点使用</a></dd>
          </dl>
        </li>

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">服务</a>
          <dl class="layui-nav-child">
            <dd class="layui-nav-item"><a href="/user/bought"><i class="icon ptfont pticon-billslipinvoice"></i>购买记录</a></dd>
            <dd class="layui-nav-item"><a href="/user/ticket"><i class="icon ptfont pticon-mailboxboxletter"></i>工单系统</a></dd>
            <dd class="layui-nav-item"><a href="/user/trafficlog"><i class="icon ptfont pticon-graphstatsanalyt"></i>节点观察</a></dd>
          </dl>
        </li>
        
        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">其他</a>
          <dl class="layui-nav-child">              
            <dd class="layui-nav-item"><a href="/user/detect/log"><i class="icon ptfont pticon-sortfilterarrang"></i>审计记录</a></dd>
            <dd class="layui-nav-item"><a href="/user/relay"><i class="icon ptfont pticon-circuitnetworkpa"></i>中转规则</a></dd>
          </dl>
        </li>
        
        {if $user->isAdmin()}
        <hr>
        <li class="layui-nav-item manage"><a href="/admin"><i class="icon ptfont pticon-gearcogsetupup"></i>管理</a></li>
        {/if}
      </ul>
    </div>

  </div>