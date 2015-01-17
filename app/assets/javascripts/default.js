// namespace
window.semantic = {
  handler: {}
};

// ready event
semantic.ready = function() {
  var
    $menu = $('#toc');

  // $('.ui.sidebar')
  //   .sidebar('attach events', '.launch.button')
  //   .sidebar('attach events', '.launch.item');
  $('.launch.button, .launch.item')
      .on('click', function(event) {
        $menu.sidebar('show');
        event.preventDefault();
      })
    ;

  $('select.dropdown')
    .dropdown()
  ;

  $('.ui.dropdown')
    .dropdown({
      on: 'hover'
    })
  ;

  $('.ui.checkbox')
    .checkbox()
  ;
}

// attach ready event
$(document)
  .ready(semantic.ready)
;
