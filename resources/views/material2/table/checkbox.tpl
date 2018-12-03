{foreach $table_config['total_column'] as $key => $value}
<span class="check_btn">

<input data-column="{$key}" {if in_array($key, $table_config['default_show_column']) || count($table_config['default_show_column']) == 0}checked=""{/if} class="toggle-vis hide inp-cbx" id="checkbox_{$key}" name="checkbox_{$key}" type="checkbox">
<label for="checkbox_{$key}" class="cbx">
<span>
    <svg width="12px" height="10px" viewBox="0 0 12 10">
      <polyline points="1.5 6 4.5 9 10.5 1"></polyline>
    </svg>
  </span>
  <span>{$value}</span>
</label>

</span>	
{/foreach}

<hr>