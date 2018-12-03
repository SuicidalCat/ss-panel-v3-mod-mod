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

<div class="layui-layout layui-layout-admin theme-admin">

  {include file='head-nav.tpl'}

  <div class="layui-side layui-side-menu" id="side-menu">
    <div class="layui-side-scroll">

      <div class="layui-logo logo">
        <a href="/admin/"><em>Spanel</em></a>
      </div>
      
      <h2 class="admin-h2">管理后台</h2>

      <ul class="layui-nav layui-nav-tree">

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">控制台</a>
          <dl class="layui-nav-child">  
            <dd><a href="/admin"><i class="icon ptfont pticon-dashboardperforman"></i>首页</a></dd>
            <dd><a href="/admin/announcement"><i class="icon ptfont pticon-speakerloudsound"></i>公告管理</a></dd>
            <dd><a href="/admin/ticket"><i class="icon ptfont pticon-mailboxboxletter"></i>工单管理</a></dd>
          </dl>
        </li>

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">节点</a>
          <dl class="layui-nav-child">
            <dd><a href="/admin/node"><i class="icon ptfont pticon-locationpinmap1"></i>节点列表</a></dd>
            <dd><a href="/admin/trafficlog"><i class="icon ptfont pticon-piechartgraphs"></i>流量记录</a></dd>
            <dd><a href="/admin/block"><i class="icon ptfont pticon-removedeleteaddr"></i>已封IP</a></dd>
            <dd><a href="/admin/unblock"><i class="icon ptfont pticon-addresspinverifi"></i>已解封IP</a></dd>
          </dl>
        </li>     

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">商品</a>
          <dl class="layui-nav-child">
            <dd><a href="/admin/shop"><i class="icon ptfont pticon-bucketdroppaint"></i>套餐列表</a></dd>
            <dd><a href="/admin/code"><i class="icon ptfont pticon-dollarcurrencymo"></i>充值卡</a></dd>            
            <dd><a href="/admin/coupon"><i class="icon ptfont pticon-moneycurrencynot"></i>优惠码</a></dd>
            <dd><a href="/admin/bought"><i class="icon ptfont pticon-billslipinvoice"></i>购买记录</a></dd>
            <dd><a href="/admin/yftOrder"><i class="icon ptfont pticon-billslipinvoice"></i>yft交易记录</a></dd>            
          </dl>
        </li>

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">用户</a>
          <dl class="layui-nav-child">
            <dd><a href="/admin/user"><i class="icon ptfont pticon-Userpersonavtar"></i>用户列表</a></dd>      
            <dd><a href="/admin/invite"><i class="icon ptfont pticon-moneycurrencynot"></i>邀请码&返利</a></dd>
            <dd><a href="/admin/login"><i class="icon ptfont pticon-directionpathboa"></i>登录IP</a></dd>
            <dd><a href="/admin/alive"><i class="icon ptfont pticon-Antennaradiosign"></i>在线IP</a></dd>
          </dl>
        </li>

        <li class="layui-nav-item layui-nav-itemed">
          <a href="javascript:;" class="tsub">管理</a>
          <dl class="layui-nav-child">            
            <dd><a href="/admin/detect"><i class="icon ptfont pticon-shieldsafeprotec"></i>审计规则</a></dd>
            <dd><a href="/admin/detect/log"><i class="icon ptfont pticon-sortfilterarrang"></i>审计记录</a></dd>
            <dd><a href="/admin/relay"><i class="icon ptfont pticon-circuitnetworkpa"></i>中转规则</a></dd>
            <dd><a href="/admin/auto"><i class="icon ptfont pticon-touchhandgesture"></i>下发指令</a></dd>
          </dl>
        </li>

        <hr>
        <li class="layui-nav-item manage">
          <a href="/user"><i class="icon ptfont pticon-househomeshelter"></i>用户中心</a>
        </li>
        
      </ul>
    </div>

  </div>