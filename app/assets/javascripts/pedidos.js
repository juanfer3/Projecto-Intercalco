$(document).on('turbolinks:load', function() {



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


  /*------------------Function Sumar Totales-------------------------*/
  var sumarTotales= function(event){

    var total = 0;
    var cantInput = 1

    var contador=$("#entregas .cantidad").length
    contador = parseFloat(contador)

    for (var i = 0; i < contador; i++) {

      var valores = $('.cantidad:eq('+i+')').val()
      valores = parseFloat(valores)
      total = total + valores

      if (isNaN(total)) {

      } else {
        $("#total").val(total)
      }

    }
  }

  /*---------------------Ejecutar Function Sumar Totales al iniciar la pagina----------------------------*/
$('.cantidad').focusout(function(event) {
  toastr.success("focus Out")
  /*Fucntion Totales*/
    sumarTotales();
  /*/Function Totalse*/
});

});
