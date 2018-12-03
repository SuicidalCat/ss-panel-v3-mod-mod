{include file='page-head.tpl'}

<div class="layui-body">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

    <h1 class="site-h1">充值结果</h1>

    <!--content-->
    <div class="layui-row layui-col-space20">

        <div class="layui-col-md12">

            <div class="layui-card">
                <div class="layui-card-body">
                    {if ($success == 1)}
                        <p>已充值成功 {$money} 元！请进入 <a href="/user/shop">套餐购买</a> 页面来选购您的套餐。</p>
                    {else}
                        <p>充值失败，请检查账单或联系管理员。</p>
                    {/if}
                </div>
            </div>

        </div>

    </div>
    <!--content:end-->

</div>
</div>
</div>

{include file='page-foot.tpl'}