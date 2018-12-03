{include file='page-head.tpl'}
<div class="layui-body user-invite">
    <div class="layadmin-tabsbody-item layui-show">
        <div class="layui-container">
            <h1 class="site-h1">邀请码</h1>

            <div class="layui-card">
              <div class="layui-tab layui-tab-brief">
                  <ul class="layui-tab-title">
                    <li><a href="/user/edit">个人中心</a></li>
                    <li class="layui-this">邀请码</li>
                    <li><a href="/user/profile">登录记录</a></li>
                  </ul>
              </div>
            </div>

            <!--content-->
            <div class="layui-row layui-col-space20">
            	<div class="layui-col-md5">
                    <div class="layui-card">
                        <div class="layui-card-header">邀请</div>
                        <div class="layui-card-body" style="min-height:48px">
                            <p>亲每邀请1位用户注册：即获得 <span class="layui-badge layui-bg-blue">{$config["invite_gift"]} G</span> 流量奖励。</p>
                            <p>对方将获得 <span class="layui-badge layui-bg-blue">{$config["invite_get_money"]}</span> 元奖励作为初始资金。</p>
                            <p>对方充值，返利为：对方充值金额的 <span class="layui-badge layui-bg-blue">{$config["code_payback"]} %</span></p>
                            <hr>
                            已获得返利：<code>{$paybacks_sum}</code> 元
                        </div>
                    </div>
                </div>
                
                {if $user->class!=0}
                    
                    {if $user->invite_num!=-1}
                    <div class="layui-col-md7">
                        <div class="layui-card">
                            <div class="layui-card-header">邀请链接</div>
                            <div class="layui-card-body">
                                <p>剩余可邀请次数：{if $user->invite_num<0}无限{else} <span class="layui-badge layui-bg-blue">{$user->invite_num}</span>{/if}</p>
                                <p>邀请链接请给认识和需要的人，复制以下链接发给被邀请者</p>
                                <p>
                                    <input type="text" id="d_code" class="layui-input" value="{$config["baseUrl"]}/auth/register?code={$code->code}" readonly>
                                </p>
                                <p><button class="layui-btn layui-btn-sm copy-btn layui-btn-primary" data-clipboard-target="#d_code">点击复制</button></p>
                            </div>
                        </div>
                    </div>
                    {/if}

                    {if $config['invite_price']>=0}
                    <div class="layui-col-md12">
                        <div class="layui-card" id="buy-invite">
                            <div class="layui-card-header">购买邀请次数</div>
                            <div class="layui-card-body">
                                <p>邀请次数价格：<code>{$config['invite_price']}</code> 元/个</p>
                                <div class="layui-form layui-form-pane">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="buy-invite-num">输入次数</label>
                                        <div class="layui-input-inline">
                                          <input id="buy-invite-num" type="num" name="num" class="layui-input">
                                        </div>
                                        <div class="layui-form-mid">
                                            <button id="buy-invite" class="layui-btn">购买</button>
                                        </div>
                                    </div>
                                </div>                                
                            </div>
                        </div>
                    </div>
                    {/if}               

                {else}

                    <div class="layui-col-md7">
                        <div class="layui-card">
                            <div class="layui-card-header">邀请链接</div>
                            <div class="layui-card-body">
                                {$user->user_name}，您不是VIP暂时无法使用邀请链接，<a href="/user/shop" class="layui-btn">升级VIP</a>
                            </div>
                        </div>
                    </div>

                {/if}
                
                
                
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">邀请状态</div>
                        <div class="layui-card-body">
                            <div class="table-over">
                           {$paybacks->render()}
                            <table class="layui-table">
                                <thead>
                                    <tr>
                                        <th>###</th>
                                        <th>被邀请用户ID</th>
                                        <th>获得返利</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {foreach $paybacks as $payback}
                                    <tr>
                                        <td>{$payback->id}</td>
                                        <td>{$payback->userid}</td>
                                        <td>{$payback->ref_get} 元</td>
                                    </tr>
                                    {/foreach}
                                </tbody>
                            </table>
                           {$paybacks->render()}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--content:end-->
        </div>
    </div>
</div>
{include file='page-foot.tpl'}
<script>
require(['jquery'], function($){

	$("#invite-btn").click(function () {
        $.ajax({
            type: "POST",
            url: "/user/invite",
            dataType: "json",
            success: function (data) {
                window.location.reload();
            },
            error: function (jqXHR) {
				layer.msg("发生错误：" + jqXHR.status);
            }
        })
    });

    $("#buy-invite").click(function () {
        $.ajax({
            type: "POST",
            url: "/user/buy_invite",
            dataType: "json",
            data: {
                num: $("#buy-invite-num").val(),
            },
            success: function (data) {
                 if (data.ret) {
                    layer.msg(data.msg);
                    window.setTimeout("location.href='/user/invite'", {$config['jump_delay']});
                } else {
                    layer.msg(data.msg);
                }
            },
            error: function (jqXHR) {
                layer.msg(data.msg+"出现了一些错误");
            }
        })
    });

})
</script>