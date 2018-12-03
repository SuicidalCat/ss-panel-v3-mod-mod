{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

    <h1 class="site-h1">个人中心</h1>

    <div class="layui-card">
      <div class="layui-tab layui-tab-brief">
          <ul class="layui-tab-title">
            <li class="layui-this">个人中心</li>
            <li><a href="/user/invite">邀请码</a></li>
            <li><a href="/user/profile">登录记录</a></li>
          </ul>
      </div>
    </div>

    <!--content-->
    <div class="layui-row layui-col-space20">

        <div class="layui-col-md12">
            <div class="layui-row layui-col-space20">
                <div class="layui-col-md4">

                  <div class="layui-card">
                    <div class="layui-card-header">修改登录密码</div>
                    <div class="layui-card-body">
                        
                        <div class="layui-form layui-form-pane">
                          <div class="layui-form-item">
                            <label class="layui-form-label">当前密码</label>
                            <div class="layui-input-block">
                              <input id="oldpwd" type="password" class="layui-input">
                            </div>
                          </div>
                           <div class="layui-form-item">
                            <label class="layui-form-label">新密码</label>
                            <div class="layui-input-block">
                              <input id="pwd" type="password" class="layui-input">
                            </div>
                          </div>
                           <div class="layui-form-item">
                            <label class="layui-form-label">重复新密码</label>
                            <div class="layui-input-block">
                              <input id="repwd" type="password" class="layui-input">
                            </div>
                          </div>
                          <div class="layui-form-item">
                            <div class="layui-input-block">
                              <button class="layui-btn" id="pwd-update"><i class="icon ptfont pticon-editupdatepencil"></i> 立即修改</button>
                            </div>
                          </div>
                        </div>

                    </div>
                  </div>

                </div>        

                <div class="layui-col-md4">

                  <div class="layui-card">
                    <div class="layui-card-header">个人信息</div>
                    <div class="layui-card-body">

                        <div class="layui-form layui-form-pane">
                          <div class="layui-form-item">
                            <label class="layui-form-label">昵称</label>
                            <div class="layui-input-block">
                              <input class="layui-input" value="{$user->user_name}" readonly>
                            </div>
                          </div>
                          <div class="layui-form-item">
                            <label class="layui-form-label">邮箱</label>
                            <div class="layui-input-block">
                              <input class="layui-input" value="{$user->email}" readonly>
                            </div>
                          </div>
                          <div class="layui-form-item">
                            <label class="layui-form-label">用户到期</label>
                            <div class="layui-input-block">
                              <input class="layui-input" value="不续费后,将于{$user->expire_in|date_format:'%Y-%m-%d'}注销" readonly>
                            </div>
                          </div>
                          
                          <div class="layui-form-item">
                            <div class="layui-input-block">
                              <a class="layui-btn" href="kill"><i class="icon ptfont pticon-deletetrashdust"></i> 注销账号</a>
                            </div>
                          </div>
                        </div>

                    </div>
                  </div>

                </div>

                <div class="layui-col-md4">

                  <div class="layui-card">
                    <div class="layui-card-header">节点信息</div>
                    <div class="layui-card-body">
                        
                        <table class="layui-table">
                            <colgroup>
                              <col width="100">
                              <col>
                            </colgroup>
                            <tbody>               
                              <tr>
                                <td>端口</td>
                                <td>{$user->port}</td>
                              </tr>
                               <tr>
                                <td>连接密码</td>
                                <td>{$user->passwd}</td>
                              </tr>
                              <tr>
                                <td>加密方式</td>
                                <td>{$user->method}</td>
                              </tr>
                              <tr>
                                <td>协议</td>
                                <td>{$user->protocol}</td>
                              </tr>
                              <tr>
                                <td>混淆方式</td>
                                <td>{$user->obfs}</td>
                              </tr>
                            </tbody>
                          </table>

                    </div>
                  </div>

                </div>
            </div>
        </div>

        

        <div class="layui-col-md4">

          <div class="layui-card">
            <div class="layui-card-header">修改节点连接密码</div>
            <div class="layui-card-body">
                
                <div class="layui-form layui-form-pane">
                  <div class="layui-form-item">
                    <label class="layui-form-label">当前密码</label>
                    <div class="layui-input-block">
                      <input id="ajax-user-passwd" class="layui-input" value="{$user->passwd}" readonly>
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <label class="layui-form-label">新连接密码</label>
                    <div class="layui-input-block">
                      <input class="layui-input" id="sspwd" type="text">
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <div class="layui-input-block">
                      <button class="layui-btn" id="ss-pwd-update"><i class="icon ptfont pticon-editupdatepencil"></i> 立即修改</button>
                    </div>
                  </div>
                </div>

            </div>
          </div>

        </div>


        <div class="layui-col-md4">

          <div class="layui-card">
            <div class="layui-card-header">每日邮件接收设置</div>
            <div class="layui-card-body">
                
                <div class="layui-form layui-form-pane">
                  <div class="layui-form-item">
                    <label class="layui-form-label">当前设置</label>
                    <div class="layui-input-block">
                      <input class="layui-input" value="{if $user->sendDailyMail==1}发送{else}不发送{/if}" readonly>
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <label class="layui-form-label">发送设置</label>
                    <div class="layui-input-block">
                      <select id="mail" class="layui-select">
                        <option value="1">发送</option>
                        <option value="0">不发送</option>
                      </select>
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <div class="layui-input-block">
                      <button class="layui-btn" id="mail-update"><i class="icon ptfont pticon-editupdatepencil"></i> 提交</button>
                    </div>
                  </div>
                </div>

            </div>
          </div>

        </div>


        <div class="layui-col-md4">

          <div class="layui-card">
            <div class="layui-card-header">主题修改</div>
            <div class="layui-card-body">
                
                <div class="layui-form layui-form-pane">
                  <div class="layui-form-item">
                    <label class="layui-form-label">当前主题</label>
                    <div class="layui-input-block">
                      <input class="layui-input" value="{$user->theme}" readonly>
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <label class="layui-form-label">主题</label>
                    <div class="layui-input-block">
                        <select id="theme" class="layui-select">
                            {foreach $themes as $theme}
                                <option value="{$theme}">{$theme}</option>
                            {/foreach}
                        </select>
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <div class="layui-input-block">
                      <button class="layui-btn" id="theme-update"><i class="icon ptfont pticon-editupdatepencil"></i> 提交</button>
                    </div>
                  </div>
                </div>

            </div>
          </div>

        </div>


        <div class="layui-col-md12">

          <div class="layui-card">
            <div class="layui-card-header">协议&混淆设置</div>

            <div class="layui-card-body">
              <p>当前协议：<span id="ajax-user-protocol" class="layui-badge layui-bg-blue">{$user->protocol}</span></p>
              <p>注意1：如果需要兼容 SS/SSD 请选择带_compatible的兼容选项！</p>
              <p>注意2：如果您使用 SS/SSD 此处请直接设置为 origin！</p>
              <p>注意3：auth_chain 系为实验性协议，可能造成不稳定或无法使用，开启前请询问是否支持</p>
              <div class="layui-form layui-form-pane">
                  <div class="layui-form-item">
                    <label class="layui-form-label">协议</label>
                    <div class="layui-input-block">
                     <select id="protocol" class="form-control">
                        {$protocol_list = $config_service->getSupportParam('protocol')}
                        {foreach $protocol_list as $protocol}
                          <option value="{$protocol}" {if $user->protocol == $protocol}selected="selected"{/if}>[{if URL::CanProtocolConnect($protocol) == 3}SS/SSD/SSR{else}SSR{/if} 可连接] {$protocol}</option>
                        {/foreach}
                      </select>
                    </div>
                  </div>
              </div>
            </div>

            <div class="layui-card-body">
              <p>当前混淆方式：<span id="ajax-user-obfs" class="layui-badge layui-bg-blue">{$user->obfs}</span></p>
                    <p>注意1：如果需要兼容 SS/SSD 请选择带_compatible的兼容选项！</p>
                    <p>注意2：SS/SSD 和 SSR 支持的混淆类型有所不同，simple_obfs_* 为 SS/SSD 的混淆方式，其他为 SSR 的混淆方式！</p>
                <div class="layui-form layui-form-pane">
                  <div class="layui-form-item">
                    <label class="layui-form-label">混淆方式</label>
                    <div class="layui-input-block">
                     <select id="obfs" class="form-control">
                        {$obfs_list = $config_service->getSupportParam('obfs')}
                        {foreach $obfs_list as $obfs}
                          <option value="{$obfs}" {if $user->obfs == $obfs}selected="selected"{/if}>[{if URL::CanObfsConnect($obfs) >= 3}SS/SSD/SSR{else}{if URL::CanObfsConnect($obfs) == 1}SSR{else}SS/SSD{/if}{/if} 可连接] {$obfs}</option>
                        {/foreach}
                      </select>
                    </div>
                  </div>                 
                </div>
            </div>

            <div class="layui-card-body">
              <p>当前混淆参数：<span id="ajax-user-obfs-param" class="layui-badge layui-bg-blue">{$user->obfs_param}</span></p>
                    <p>注意：如果需要兼容 SS/SSD 请留空！</p>
              <div class="layui-form layui-form-pane">
                  <div class="layui-form-item">
                    <label class="layui-form-label">输入参数</label>
                    <div class="layui-input-block">
                      <input id="obfs-param" class="layui-input" value="">
                    </div>
                  </div>

                  <div class="layui-form-item">
                    <div class="layui-input-block">
                      <button class="layui-btn" id="ssr-update"><i class="icon ptfont pticon-editupdatepencil"></i> 立即修改</button>
                    </div>
                  </div>

              </div>
            </div>

          </div>

        </div>


        {if $config['enable_telegram'] == 'true'}
        <div class="layui-col-md6">

          <div class="layui-card">
            <div class="layui-card-header">Telegram 绑定</div>
            <div class="layui-card-body">

                <p>Telegram 添加机器人账号 <a href="https://t.me/{$telegram_bot}">@{$telegram_bot}</a>，拍下下面这张二维码发给它。</p><hr>

                <div class="text-center">
                  <div id="telegram-qr"></div>
                  {if $user->telegram_id != 0}当前绑定：<a href="https://t.me/{$user->im_value}">@{$user->im_value}</a>{/if}
                </div>

                <hr><div class="text-center"><a class="layui-btn" href="/user/telegram_reset">X 解绑</a></div>

            </div>
          </div>
        </div>  
        {/if}


        <div class="layui-col-md6">

          <div class="layui-card">
            <div class="layui-card-header">修改加密方式</div>
            <div class="layui-card-body">
              注意：SS 和 SSR 支持的加密方式有所不同，请根据实际情况来进行选择！
            </div>
            <div class="layui-card-body">
                
                <div class="layui-form layui-form-pane">
                  <div class="layui-form-item">
                    <label class="layui-form-label">当前加密</label>
                    <div class="layui-input-block">
                      <input id="ajax-user-method" class="layui-input" value="{$user->method}" readonly>
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <label class="layui-form-label">加密方式</label>
                    <div class="layui-input-block">
                      <select id="method" class="layui-textarea">
                        {$method_list = $config_service->getSupportParam('method')}
                        {foreach $method_list as $method}
                          <option value="{$method}" {if $user->method == $method}selected="selected"{/if}>[{if URL::CanMethodConnect($method) == 2}SS{else}SS/SSR{/if} 可连接] {$method}</option>
                        {/foreach}
                      </select>
                    </div>
                  </div>
                  <div class="layui-form-item">
                    <div class="layui-input-block">
                      <button class="layui-btn" id="method-update"><i class="icon ptfont pticon-editupdatepencil"></i> 立即修改</button>
                    </div>
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
require(['domReady','jquery','qrcode'],function(domReady,$){

    domReady(function () {

      {if $config['enable_telegram'] == 'true'}        
        var qrcode = new QRCode(document.getElementById("telegram-qr"),{
          text:'mod://bind/{$bind_token}',
          width: 200,
          height: 200
        });
      {/if}

        $("#pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "password",
                dataType: "json",
                data: {
                    oldpwd: $("#oldpwd").val(),
                    pwd: $("#pwd").val(),
                    repwd: $("#repwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        {literal}
                        layer.msg("修改成功", {icon: "6"}); 
                        {/literal}
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"出现错误");
                }
            })
        })

        $("#ss-pwd-update").click(function () {
            $.ajax({
                type: "POST",
                url: "sspwd",
                dataType: "json",
                data: {
                    sspwd: $("#sspwd").val()
                },
                success: function (data) {
                    if (data.ret) {
                        $("#ajax-user-passwd").html($("#sspwd").val());
                        {literal}
                        layer.msg("修改成功", {icon: "6"}); 
                        {/literal}
                    } else {
                        layer.msg("修改失败");
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"出现错误");
                }
            })
        })

        $("#mail-update").click(function () {
            $.ajax({
                type: "POST",
                url: "mail",
                dataType: "json",
                data: {
                    mail: $("#mail").val()
                },
                success: function (data) {
                    if (data.ret) {
                        {literal}
                        layer.msg("修改成功", {icon: "6"}); 
                        {/literal}
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"出现错误");
                }
            })
        })

        $("#theme-update").click(function () {
            $.ajax({
                type: "POST",
                url: "theme",
                dataType: "json",
                data: {
                    theme: $("#theme").val()
                },
                success: function (data) {
                    if (data.ret) {
                        {literal}
                        layer.msg("修改成功", {icon: "6"}); 
                        {/literal}
                        window.setTimeout("location.href='/user/edit'", {$config['jump_delay']});
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"出现错误");
                }
            })
        })

        $("#method-update").click(function () {
            $.ajax({
                type: "POST",
                url: "method",
                dataType: "json",
                data: {
                    method: $("#method").val()
                },
                success: function (data) {
                    if (data.ret) {
                        {literal}
                        layer.msg("修改成功", {icon: "6"}); 
                        {/literal}
                        window.setTimeout("location.href='/user/edit'",1000);
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"出现错误");
                }
            })
        })

        //prot edit

        $("#ssr-update").click(function () {
            $.ajax({
                type: "POST",
                url: "ssr",
                dataType: "json",
                data: {
                    protocol: $("#protocol").val(),
                    obfs: $("#obfs").val(),
                    obfs_param: $("#obfs-param").val()
                },
                success: function (data) {
                    if (data.ret) {
                      {literal}
                        layer.msg("修改成功", {icon: "6"}); 
                        {/literal}
                        $("#ajax-user-protocol").html($("#protocol").val());
                        $("ajax-user-obfs").html($("#obfs").val());
                        $("#ajax-user-obfs-param").html($("#obfs-param").val());
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"出现错误");
                }
            })
        })



        //prot edit:end


    })

})
</script>