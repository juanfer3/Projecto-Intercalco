$(document).on('turbolinks:load', function() {

  $('#pedido_factura').hide()
  
  $('form').on('click', '.remove_entregas', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_entregas', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_entrega').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

});