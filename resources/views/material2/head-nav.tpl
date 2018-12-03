<div class="layui-header">

    <ul class="layui-nav layui-layout-left">
      <li class="layui-nav-item layadmin-flexible" lay-unselect="">
        <a href="javascript:;" title="侧边伸缩" class="admin-side-toggle">
          <i class="layui-icon layui-icon-spread-left" style="font-size:20px"></i>
        </a>
      </li>
    </ul>

      <ul class="layui-nav layui-layout-right">
        <li class="layui-nav-item">
          <a href="javascript:;">
            <i class="icon ptfont pticon-Userpersonavtar"></i>
          </a>
          <div class="layui-nav-child">
            <div class="nav-u-info">
              <div class="hd">
                余额：{$user->money}元 
                <a href="/user/code" class="layui-btn layui-btn-sm"><i class="icon ptfont pticon-dollarcurrencymo"></i> 充值</a>
              </div>
              <div class="bd fix">
                <ul>
                  <li>
                    <a href="/user/edit">
                      <i class="icon ptfont pticon-Userpersonavtar"></i>
                      <span>个人中心</span>
                    </a>
                  </li>
                  <li>
                    <a href="/user/invite">
                      <i class="icon ptfont pticon-moneycurrencynot"></i>
                      <span>邀请码</span>
                    </a>
                  </li>
                </ul>
              </div>
              <div class="ft">
                <a href="/user/logout"><i class="icon ptfont pticon-poweronstandby"></i> 退出网站</a>
              </div>              
            </div>
          </div>
        </li>
        <li class="layui-nav-item">
          <a href="javascript:;"><i id="logo-notice" class="icon ptfont pticon-exclamationcaution" style="font-size:14px;font-weight:normal;"></i></a>
        </li>
      </ul>

    </div>