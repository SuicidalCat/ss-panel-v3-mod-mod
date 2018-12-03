{include file='page-head.tpl'}
<div class="layui-body user-invite">
    <div class="layadmin-tabsbody-item layui-show">
        <div class="layui-container">
            <h1 class="site-h1">充值记录(yft)</h1>

            <!--content-->
            <div class="layui-row layui-col-space20">           
                
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-card-header">充值列表</div>
                        <div class="layui-card-body">
                            <div class="table-over">
                            {$orderList->render()}
                            <table class="layui-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>订单号</th>
                                        <th>金额</th>
                                        <th>充值时间</th>
                                        <th>状态</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {if sizeof($orderList) > 0}
                                    {foreach $orderList as $order}
                                        <tr>
                                            <td>#{$order->id}</td>
                                            <td>{$order->yft_order}</td>
                                            <td>{$order->price} 元</td>
                                            <td>{$order->create_time}</td>
                                            {if ($order->state == 1)}<td>已支付</td>{else}<td>未支付</td>{/if}
                                        </tr>
                                    {/foreach}
                                    {else}
                                        <tr>
                                            <td colspan="5">暂无充值记录！</td>
                                        </tr>
                                    {/if}
                                </tbody>
                            </table>
                            <span>总共{$countPage}页</span>
                            <input type="hidden" id="countPage" value="{$countPage}">
                            <span>当前第{$currentPage}页</span>
                            <input type="hidden" id="currentPage" value="{$currentPage}">
                            <a class="btn btn-brand" href="/user/yftOrder">首页</a>
                            <a class="btn btn-brand" href="javascript:void(0)" id="pre" onclick="goto('pre')">上一页</a>
                            <a class="btn btn-brand" href="javascript:void(0)" id="nxt" onclick="goto('next')">下一页</a>
                            <a class="btn btn-brand" href="javascript:void(0)" id="end" onclick="goto('end')">尾页</a>
                            {$orderList->render()}
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
   goto=function(type) {
        var countPage = $("#countPage").val();
        var currentPage = $("#currentPage").val();
        if ("pre" == type){
            if (currentPage == 1 || currentPage == ""){
                $("#pre").removeAttr('onclick');
            }else {
                window.location.href = "/user/yftOrder?page=" + currentPage - 1;
            }
        }else if ("next" == type){
            if (currentPage == countPage){
                $("#pre").removeAttr('onclick');
            }else {
                window.location.href = "/user/yftOrder?page=" + currentPage + 1;
            }
        }else if ("end" == type){
            if (countPage == currentPage){
                $("#end").removeAttr('onclick');
            }else {
                window.location.href = "/user/yftOrder?page=" + countPage;
            }
        }
    }
})
</script>