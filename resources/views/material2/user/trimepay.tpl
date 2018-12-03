<div class="row">

        <div class="col-lg-6 col-md-6">
            <p class="card-heading">TrimePay 充值</p>
            <div class="form-group form-group-label">
                <label class="floating-label" for="amount">金额</label>
                <input class="form-control" id="amount" type="text" >
            </div>
        </div>
        <div class="col-lg-6 col-md-6">
            <p class="h5 margin-top-sm text-black-hint" id="qrarea"></p>
        </div>
</div>

    <div class="card-action">
            <button class="btn btn-flat waves-attach" id="btnSubmit" name="type" onclick="trimepay('Alipay')"><img src="/images/alipay.jpg" width="50px" height="50px" /></button>
            <button class="btn btn-flat waves-attach" id="btnSubmit" name="type" onclick="trimepay('WEPAY_QR')"><img src="/images/weixin.jpg" width="50px" height="50px" /></button>
    </div>
