<div class="doiam-pay">

	<div class="layui-tab">
	  <ul class="layui-tab-title">
	  	{if $enabled['alipay']}
			<li class="layui-this">
				<a href="javascript:void(0)" class="dmpay-type" data-pay="alipay">支付宝</a>
			</li>
		{/if}
	  	{if $enabled['wepay']}
		    <li>
		    	<a href="javascript:void(0)" class="dmpay-type" data-pay="wepay">微信支付</a>
		    </li>
	    {/if}		
		{if $enabled['qqpay']}
			<li>
				<a href="javascript:void(0)" class="dmpay-type" data-pay="qqpay">QQ支付</a>
			</li>
		{/if}
	  </ul>
	</div>

	<div class="layui-form layui-form-pane">
	  <div class="layui-form-item">
	    <label class="layui-form-label">金额</label>
	    <div class="layui-input-inline">
	      <input type="text" id="amount" class="layui-input">
	    </div>
	  </div>
	</div>

</div>

<div class="card-action">
	<div class="card-action-btn pull-left">
		<button class="layui-btn" id="daimisubmit">立即充值</button>
	</div>
</div>
