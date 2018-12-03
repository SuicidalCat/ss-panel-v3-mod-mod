{include file='admin-head.tpl'}
<div class="layui-body admin-node admin-node-create">
    <div class="layadmin-tabsbody-item layui-show">
        <div class="layui-container">
            <!--title-->
            <h1 class="site-h1">添加节点</h1>
            <!--content-->
            <form id="main_form">
                <div class="layui-row layui-col-space20">
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header">节点信息 <span>（* 为必填项）</span></div>
                            <div class="layui-card-body">
                                <div class="layui-form layui-form-pane">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="name">节点名称*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="name" name="name" type="text">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="server">节点地址*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="server" name="server" type="text">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">域名/IP</div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="node_ip">节点IP</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="node_ip" name="node_ip" type="text">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">不填则自动获取</div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="method">加密方式*</label>
                                        <div class="layui-input-inline" style="width:250px">
                                            <select id="method">
                                                <option value="rc4-md5">[SS/SSR 可连接] rc4-md5</option>
                                                <option value="rc4-md5-6">[SS/SSR 可连接] rc4-md5-6</option>
                                                <option value="aes-128-cfb">[SS/SSR 可连接] aes-128-cfb</option>
                                                <option value="aes-192-cfb">[SS/SSR 可连接] aes-192-cfb</option>
                                                <option value="aes-256-cfb" selected="selected">[SS/SSR 可连接] aes-256-cfb</option>
                                                <option value="aes-128-ctr">[SS/SSR 可连接] aes-128-ctr</option>
                                                <option value="aes-192-ctr">[SS/SSR 可连接] aes-192-ctr</option>
                                                <option value="aes-256-ctr">[SS/SSR 可连接] aes-256-ctr</option>
                                                <option value="camellia-128-cfb">[SS/SSR 可连接] camellia-128-cfb</option>
                                                <option value="camellia-192-cfb">[SS/SSR 可连接] camellia-192-cfb</option>
                                                <option value="camellia-256-cfb">[SS/SSR 可连接] camellia-256-cfb</option>
                                                <option value="bf-cfb">[SS/SSR 可连接] bf-cfb</option>
                                                <option value="cast5-cfb">[SS/SSR 可连接] cast5-cfb</option>
                                                <option value="des-cfb">[SS/SSR 可连接] des-cfb</option>
                                                <option value="des-ede3-cfb">[SS/SSR 可连接] des-ede3-cfb</option>
                                                <option value="idea-cfb">[SS/SSR 可连接] idea-cfb</option>
                                                <option value="rc2-cfb">[SS/SSR 可连接] rc2-cfb</option>
                                                <option value="seed-cfb">[SS/SSR 可连接] seed-cfb</option>
                                                <option value="salsa20">[SS/SSR 可连接] salsa20</option>
                                                <option value="chacha20">[SS/SSR 可连接] chacha20</option>
                                                <option value="chacha20-ietf">[SS/SSR 可连接] chacha20-ietf</option>
                                                <option value="none">[SS/SSR 可连接] none</option>
                                                <option value="aes-128-gcm">[SS 可连接] aes-128-gcm</option>
                                                <option value="aes-192-gcm">[SS 可连接] aes-192-gcm</option>
                                                <option value="aes-256-gcm">[SS 可连接] aes-256-gcm</option>
                                                <option value="chacha20-ietf-poly1305">[SS 可连接] chacha20-ietf-poly1305</option>
                                                <option value="xchacha20-ietf-poly1305">[SS 可连接] xchacha20-ietf-poly1305</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="rate">流量比例*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="rate" name="rate" type="text">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">自定义加密</label>
                                        <div class="layui-input-inline">
                                            <input type="checkbox" id="custom_method" name="custom_method" lay-skin="switch" lay-text="开启|关闭" checked>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">自定义协议&混淆</label>
                                        <div class="layui-input-inline">
                                            <input type="checkbox" id="custom_rss" name="custom_rss" lay-skin="switch" lay-text="开启|关闭" checked>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">单端口多用户启用</label>
                                        <div class="layui-input-inline" style="width:250px">
                                            <select id="mu_only" name="mu_only">
                                                <option value="0" {if $node->mu_only==0}selected{/if}>单端口多用户与普通端口并存</option>
                                                <option value="-1" {if $node->mu_only==-1}selected{/if}>只启用普通端口</option>
                                                <option value="1" {if $node->mu_only==1}selected{/if}>只启用单端口多用户</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12">
                        <div class="layui-card">
                            <div class="layui-card-header">
                                <span class="layui-form">
                            	<input type="checkbox" id="type" name="type" lay-skin="switch" lay-text="显示|不显示" checked>
                            </span>
                            </div>
                            <div class="layui-card-body">
                                <div class="layui-form layui-form-pane">
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="status">节点状态*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="status" name="status" type="text" value="正常">
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label" for="sort">节点类型*</label>
                                        <div class="layui-input-inline" style="width:250px">
                                            <select id="sort" name="sort">                                                
                                                <option value="0">Shadowsocks</option>
                                                <option value="1">VPN/Radius基础</option>
                                                <option value="2">SSH</option>
                                                <option value="3">PAC</option>
                                                <option value="4">APN文件外链</option>
                                                <option value="5">Anyconnect</option>
                                                <option value="6">APN</option>
                                                <option value="7">PAC PLUS(Socks 代理生成 PAC文件)</option>
                                                <option value="8">PAC PLUS PLUS(HTTPS 代理生成 PAC文件)</option>
                                                <option value="9">Shadowsocks 单端口多用户</option>
                                                <option value="10">Shadowsocks 中转</option>
                                                <option value="11">V2Ray</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">节点描述*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="info" name="info" type="text" value="暂无">
                                        </div>                                      
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">节点等级*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="class" name="class" type="text" value="0">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">不分级请填0</div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">节点群组</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="group" name="group" type="text" value="0">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">不分组填0</div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">流量上限(GB)*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="node_bandwidth_limit" name="node_bandwidth_limit" type="text" value="0">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">不使用的话请填0</div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">流量重置日*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="bandwidthlimit_resetday" name="bandwidthlimit_resetday" type="text" value="0">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">每月几日重置流量</div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">节点限速(Mbps)*</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="node_speedlimit" name="node_speedlimit" type="text" value="0">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">对于每个用户端口</div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">节点限制连接IP数</label>
                                        <div class="layui-input-inline">
                                            <input class="layui-input" id="node_connector" name="node_connector" type="text" value="0">
                                        </div>
                                        <div class="layui-form-mid layui-word-aux">用户在节点可连接IP数量</div>
                                    </div>                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-col-md12 tac">
                        <button id="submit" type="submit" class="layui-btn"><i class="icon ptfont pticon-addnewbuttonpl"></i> 立即添加</button>
                        <a class="layui-btn layui-btn-primary" href="javascript:history.go(-1);">返回</a>
                    </div>
                </div>
            </form>
            <!--content:end-->
        </div>
    </div>
</div>
{include file='admin-foot.tpl'}

{literal}
<script>
require(['jquery','validate'], function($,validate){

    jQuery.extend(jQuery.validator.messages, {  
        required: "必填内容"
    });
	
    $('#main_form').validate({
        rules: {
          name: {required: true},
          server: {required: true},
          method: {required: true},
          rate: {required: true},
          info: {required: true},
          group: {required: true},
          status: {required: true},
          node_speedlimit: {required: true},
          sort: {required: true},
          node_bandwidth_limit: {required: true},
          node_connector:{required: true},
          bandwidthlimit_resetday: {required: true}
        },

        submitHandler: function() {
            if(document.getElementById('custom_method').checked)
            {
                var custom_method=1;
            }
            else
            {
                var custom_method=0;
            }

            if(document.getElementById('type').checked)
            {
                var type=1;
            }
            else
            {
                var type=0;
            }            
            if(document.getElementById('custom_rss').checked)
            {
                var custom_rss=1;
            }
            else
            {
                var custom_rss=0;
            }
            {/literal}


            $.ajax({
                type: "POST",
                url: "/admin/node",
                dataType: "json",
                data: {
                    name: $("#name").val(),
                    server: $("#server").val(),
                    node_ip: $("#node_ip").val(),
                    method: $("#method").val(),
                    custom_method: custom_method,
                    rate: $("#rate").val(),
                    info: $("#info").val(),
                    type: type,
                    group: $("#group").val(),
                    status: $("#status").val(),
                    node_speedlimit: $("#node_speedlimit").val(),
                    node_connector: $("#node_connector").val(),                    
                    sort: $("#sort").val(),
                    class: $("#class").val(),
                    node_bandwidth_limit: $("#node_bandwidth_limit").val(),
                    bandwidthlimit_resetday: $("#bandwidthlimit_resetday").val(),
                    custom_rss: custom_rss,
                    mu_only: $("#mu_only").val()
                    {literal}
                },
                success: function (data) {
                    if (data.ret) {
                        layer.msg(data.msg, {icon: 6}); 
                        {/literal}
                        window.setTimeout("location.href=top.document.referrer",1800);
                    } else {
                        layer.msg(data.msg);
                    }
                },
                error: function (jqXHR) {
                    layer.msg(data.msg+"  发生错误了");
                }
            });
        }
    });


});
</script>