{include file='page-head.tpl'}

<div class="layui-body user-code">
<div class="layadmin-tabsbody-item layui-show">
<div class="layui-container">

	<div class="layui-row layui-card" id="top-step">
		<div class="layui-col-md4 layui-col-sm4 current">
			<span class="layui-badge">1</span> 账户充值
		</div>
		<div class="layui-col-md4 layui-col-sm4">
			<a href="/user/shop"><span class="layui-badge">2</span> 购买套餐</a>
		</div>
		<div class="layui-col-md4 layui-col-sm4">
			<a href="/user/node"><span class="layui-badge">3</span> 节点使用</a>
		</div>
	</div>

	<!--title-->
	<h1 class="site-h1">充值</h1>

	<!--content-->
	<div class="layui-row layui-col-space20" id="page-pay">

		<div class="layui-col-md4">
			<div class="layui-card pay-con">
		        <div class="layui-card-header">余额 <div class="layui-layout-right"><a href="/user/code" class="layui-btn layui-btn-primary layui-btn-sm">刷新</a></div> </div>
		        <div class="layui-card-body">
		        	<div class="price">
		        		<div><span>{$user->money}</span>元</div>
		        		<p>余额不足时请及时充值</p>
		        	</div>		        	
		        </div>
		      </div>
		</div>

		<div class="layui-col-md8">

          <div class="layui-card">
	        <div class="layui-card-body">
	        	<!--tab-->
	        	<div class="layui-tab layui-tab-brief" lay-filter="payfor">
				  <ul class="layui-tab-title">				    
				    {if $pmw!=''}
				    	<li class="layui-this">扫码充值</li>
				    {/if}
				    <li {if $pmw!=''}{else}class="layui-this"{/if}>充值卡</li>
				  </ul>
				  <div class="layui-tab-content">
				  	
				  	{if $pmw!=''}
    				<div class="layui-tab-item layui-show pay-show">

					{$pmw}

    				</div>
    				{/if}

    				<div class="layui-tab-item {if $pmw!=''}{else}layui-show{/if}">
						<div class="layui-row">
							<div class="layui-col-md5">
								<div class="layui-form">
									<p><span class="layui-badge layui-bg-gray">1</span></p>
									<a href="" class="layui-btn">买卡 →</a>
									<div class="layui-word-aux layui-input-inline">自动发货，自助购买</div>
								</div>
							</div>
							<div class="layui-col-md7">								
						      	<div class="layui-form layui-form-pane">
						      		<p><span class="layui-badge layui-bg-gray">2</span></p>
									  <div class="layui-form-item">
									    <label class="layui-form-label" for="code">输入充值卡</label>
									    <div class="layui-input-inline">
									      <input id="code" type="text" name="title" class="layui-input">
									    </div>
									    <div class="layui-form-mid">
									    	<button class="layui-btn" lay-submit id="card-update">充值</button>
									    </div>
									  </div>
								</div>
							</div>
						</div>				  		
				  	</div>

				  </div>
				</div>      
	        	<!--tab:end-->
	        </div>
	      </div>

	    </div>	    

	    <div class="layui-col-md12">

	      <div class="layui-card">
	        <div class="layui-card-header">充值记录</div>
	        <div class="layui-card-body">
	        	{$codes->render()}
	        	<div class="table-over">
	        	<table class="layui-table">
				  <colgroup>
				    <col width="10%">
				    <col width="30%">
				    <col width="15%">
				    <col width="15%">
				    <col width="15%">
				    <col>
				  </colgroup>
				  <thead>
				    <tr>
				      <th>ID</th>
				      <th>代码</th>
				      <th>类型</th>
				      <th>操作</th>
				      <th>操作时间</th>
				    </tr> 
				  </thead>
				  <tbody>
				   	{foreach $codes as $code}
						{if $code->type!=-2}
							<tr>
								<td>#{$code->id}</td>
								<td>{$code->code}</td>
								{if $code->type==-1}
								<td>金额充值</td>
								{/if}
								{if $code->type==10001}
								<td>流量充值</td>
								{/if}
								{if $code->type==10002}
								<td>用户续期</td>
								{/if}
								{if $code->type>=1&&$code->type<=10000}
								<td>等级续期 - 等级{$code->type}</td>
								{/if}
								{if $code->type==-1}
								<td>充值 {$code->number} 元</td>
								{/if}
								{if $code->type==10001}
								<td>充值 {$code->number} GB 流量</td>
								{/if}
								{if $code->type==10002}
								<td>延长账户有效期 {$code->number} 天</td>
								{/if}
								{if $code->type>=1&&$code->type<=10000}
								<td>延长等级有效期 {$code->number} 天</td>
								{/if}
								<td>{$code->usedatetime}</td>
							</tr>
						{/if}
					{/foreach}			    
				  </tbody>
				</table>
				</div>
				{$codes->render()}
	        </div>
	      </div>

        </div>

    </div>
	<!--content:end-->

</div>
</div>
</div>

<div id="loading-modal" class="hide layout">
	<div class="layout-con">
		正在处理，不要离开...
	</div>
</div>

{include file='page-foot.tpl'}