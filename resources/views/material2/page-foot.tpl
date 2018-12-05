</div>
<div class="layadmin-body-shade" layadmin-event="shade"></div>

<div id="page-loading">
	<div class="lds-dual-ring"></div>
</div>
{if $config["enable_crisp"] == 'true'}{include file='crisp.tpl'}{/if}
<script>
window.sp={
    js:  "{$config['baseUrl']}/theme/sp/assets/",
    ver: '1.1',
    jump_delay :'{$config['jump_delay']}',
    timestamp : '{time()}'
};
</script>
<script src="/theme/sp/assets/seed.js"></script>

</body>
</html>