table_1 = $('#table_1').DataTable({
      ajax: {
              url: '{$table_config['ajax_url']}',
              type: "POST"
            },
      processing: true,
      serverSide: true,
      order: [[ 0, 'desc' ]],
      stateSave: true,
      autoWidth:true,
      columnDefs: [
      {
            targets: ['_all'],
            visible: true,
            className: 'show'
        }

      ],
      columns: [
            {foreach $table_config['total_column'] as $key => $value}
              { "data": "{$key}"},
            {/foreach}
      ],
      {include file='table/lang_chinese.tpl'}
    })    

    $('.toggle-vis').on('change', function (e){

       e.preventDefault();
       console.log($(this).attr('data-column'));

       var th = $(this).attr('data-column');
       var tbcolumn = table_1.column('.'+th );

       if( $(this).is(":checked") ){
          tbcolumn.visible(!tbcolumn.visible());
          localStorage.setItem(window.location.href + '-haschecked-checkbox_' + th, true);
       }else{
          tbcolumn.visible(false);
          localStorage.setItem(window.location.href + '-haschecked-checkbox_' + th, false);
       }

    });


    var has_init = JSON.parse(localStorage.getItem(window.location.href + '-hasinit'));
    if (has_init != true) {
        localStorage.setItem(window.location.href + '-hasinit', true);
        {foreach $table_config['default_show_column'] as $key => $value}
          table_1.column('.{$value}').visible(true);
          localStorage.setItem(window.location.href + '-haschecked-checkbox_{$value}', true);
        {/foreach}
    } else {
        {foreach $table_config['total_column'] as $key => $value}
            var checked = JSON.parse(localStorage.getItem(window.location.href + '-haschecked-checkbox_{$key}'));
            if (checked == true) {
                document.getElementById('checkbox_{$key}').checked = true;
                table_1.column('.{$key}').visible(true);
            } else {
                document.getElementById('checkbox_{$key}').checked = false;
                table_1.column('.{$key}').visible(false);
            }
        {/foreach}
    }
