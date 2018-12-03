{include file='page-head.tpl'}

<div class="layui-body user-shop">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<div class="layui-row layui-card" id="top-step">
		<div class="layui-col-md4 layui-col-sm4">
			<a href="/user/code"><span class="layui-badge">1</span> 賬戶儲值</a>
		</div>
		<div class="layui-col-md4 layui-col-sm4 current">
			<span class="layui-badge">2</span> 資源包購買
		</div>
		<div class="layui-col-md4 layui-col-sm4">
			<a href="/user/node"><span class="layui-badge">3</span> 接入點列表</a>
		</div>
	</div>

	<!--title-->
	<!--h1 class="site-h1">购买套餐</h1-->

	<!--content-->
	<div class="layui-row layui-col-space20" id="page-shop">

	  	<div class="layui-col-md4" id="page-pay">
			<div class="layui-card">
		        <div class="layui-card-header">可用餘額 <div class="layui-layout-right"><a href="/user/code" class="layui-btn layui-btn-sm"><i class="icon ptfont pticon-dollarcurrencymo"></i> 儲值</a> <a href="/user/bought" class="layui-btn layui-btn-primary layui-btn-sm">訂購記錄</a></div> </div>
		        <div class="layui-card-body">
		        	<div class="price">
		        		<div><span>{$user->money}</span>元</div>
								<p>不足的餘額將會導致自動續費失敗，服務被暫停</p>
		        	</div>		        	
		        </div>
		      </div>
		</div>

		
		<div class="layui-col-md8" id="page-node">

	      <div class="layui-card learn">
	        <div class="layui-card-header">使用指導</div>
	        <div class="layui-card-body" style="min-height:82px">
	        	{include file='user/learn.tpl'}
	        </div>
	      </div>

        </div>

	  	<div class="layui-col-md12 meals">

  			<h1 class="site-h1">資源包套餐</h1>

			{$shops->render()}
        	<div class="layui-row layui-col-space20">
				{foreach $shops as $shop}
				<div class="meal-con layui-col-md3 layui-col-sm6" id="{$shop->id}">
					<div class="meal">
						<div class="con">
							<div class="hd theme-colorbg">
								<div class="hd-con">
									<span><sup>￥</sup>{$shop->price}</span> 元
									<p class="bd">{$shop->name}</p>
								</div>
							</div>
							<div class="ft" style="min-height:180px;"><!--根据套餐内容多少调整最佳高度-->
								<table class="layui-table" lay-skin="line" style="border-width: 0">
							      <colgroup>
							        <col width="80">
							        <col>
							      </colgroup>
							      <tbody>
							      	{if !$shop->bandwidth()=='0'}
								        <tr>
								          <td>傳輸量</td><td>{$shop->bandwidth()} G 每30天</td>
								        </tr>
							        {/if}
							        {if !$shop->expire()=='0'}
							        <tr>
							          <td>賬戶有效期</td><td>{$shop->expire()} 天</td>
							        </tr>
							        {/if}
							        {if !$shop->user_class()=='0'}
							        <tr>
							          <td>接入權限</td>
							          <td>
							          	Lv.{$shop->user_class()} 
							          	{if !$shop->class_expire()=='0'}
							          		（有效期{$shop->class_expire()}天）
							          	{else}
							          		（不过期）
							        	{/if}
							          </td>
							        </tr>
							        {/if}							        
							        {if !$shop->reset_exp()=='0'||!$shop->reset()=='0'||!$shop->reset_value()=='0'}
							        <tr>
							          <td>套餐周期</td>
							          <td>
							          	{$shop->reset_exp()}天
							          </td>
							        </tr>
							        {/if}							        
							        <tr>
							          <td>鏈接速率</td>
							          <td>
							          	{if !$shop->speedlimit()=='0'}
							          	{$shop->speedlimit()} Mbps
							          	{else}
							          	不限制
							          	{/if}
							          </td>
							        </tr>							        
							        <tr>
							          <td>鏈接數限制</td>
							          <td>
							          	{if !$shop->connector()=='0'}
							          	{$shop->connector()} 个
							          	{else}
							          	不限
							          	{/if}
							          </td>
							        </tr>
							        {if !$shop->auto_renew==0}
							        <tr>
							          <td>&nbsp;</td>
							          <td>
							          	每{$shop->auto_renew}天自動續費										
							          </td>
							        </tr>
							        {/if}
							        {if !$shop->auto_reset_bandwidth==0}
							        <tr>
							          <td>&nbsp;</td>
							          <td>
										自动重置
							          </td>
							        </tr>
							        {/if}
							      </tbody>
							    </table>
							</div>
						</div>
						<a href="javascript:void(0);" onClick="buy('{$shop->id}',{$shop->auto_renew},{$shop->auto_reset_bandwidth})" class="layui-btn"><i class="icon ptfont pticon-carte-commercesh"></i> 立刻訂購</a>
					</div>
				</div>				
				{/foreach}
			</div>
			{$shops->render()}

    	</div>

    </div>
	<!--content:end-->

</div>
</div>
</div>


<div id="coupon_modal" class="hide layout">
	<div class="layout-con">
		<div class="layui-form layui-form-pane">
		  <div class="layui-form-item">
		    <label class="layui-form-label">促銷代碼</label>
		    <div class="layui-input-block">
		      <input type="text" id="coupon" class="layui-input" placeholder="如無即直接跳過">
		    </div>
		  </div>
		  <div class="layui-form-item">
		    <div class="layui-input-block">
		      <button class="layui-btn" id="coupon_input" type="button"> 確定 </button>
		    </div>
		  </div>
		</div>
	</div>
</div>

<div id="order_modal" class="hide layout">
	<div class="layout-con">
		<p id="total">總金額：</p>
		<p id="name">資源包名稱：</p>
		<p id="credit">促銷額度：</p>		
		<p id="auto_reset" class="hide">到期自動續費</p>
		<div class="text-center"><button class="layui-btn" id="order_input" type="button">確認購買</button></div>
	</div>
</div>

{include file='page-foot.tpl'}