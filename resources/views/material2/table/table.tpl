<table id="table_1" class="mdl-data-table layui-table" width="100%">
  <thead>
    <tr>
      {foreach $table_config['total_column'] as $key => $value}      
        <th class="{$key} none">
          {$value}
          <span class="layui-table-sort layui-inline"><i class="layui-edge layui-table-sort-asc"></i><i class="layui-edge layui-table-sort-desc"></i></span>
        </th>
      {/foreach}
    </tr>
  </thead>
  <tbody>
  </tbody>
</table>