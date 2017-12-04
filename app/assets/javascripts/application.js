// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require moment
//= require moment/es.js
//= require select2
//= require toastr
//= require best_in_place
//= require jquery-ui
//= require best_in_place.jquery-ui
//= require_tree .




$(document).on('turbolinks:load', function() {


  jQuery(".best_in_place").best_in_place();






  /*-------------------------Insert Y Delete de Detalles de Produccion----------*/



  $("#pedido_contacto_id").select2({


     createTag: function (params) {

      // Don't offset to create a tag if there is no @ symbol
      if (params.term.indexOf('@') === -1) {

        // Return null to disable tag creation
        var mensaje='Contacto no encontrado'
        return mensaje;
      }

      return {

        id: params.term,
        text: params.term
      }
    }
  });

/*-------------------------Insert Y Delete de Entregas-----------------------*/

  $('form').on('click', '.remove_entregas', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();
    return event.preventDefault();
  });

  $('form').on('click', '.add_entregas', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_entrega').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });



 /* $('#pedido_contacto_id').change(function () {

    var client_id = $(this).find('#pedido_contacto_id').select2()
    //toastr.success(client_id)
    console.log(client_id)
    var cliente_id = $(this).find('#pedido_contacto_id').val()

    $.ajax({
      url:'/contactos/'+cliente_id+'/vista',
      method:'get',
      success: function(data){
        console.log(data)
        var data_length = data.length;
        for (var i = 0; i < data_length; i++) {
          var cliente = data[i]['cliente']["nombre"];
          //toastr.info(cliente);
          $('#cliente').html(cliente)

        }

      }
    })

  })*/

  $('#pedido_contacto_id').on("select2:select", function (e) {
    var cliente_id = e.params.data.id;
    $.ajax({
      url:'/contactos/:contacto_id/vista?id='+cliente_id+'',
      method:'get',
      success: function(data){

        var data_length = 1;

        for (var i = 0; i < data_length; i++) {

          var cliente = data["cliente"]["nombre"];
          $('#cliente').html(cliente)

        }

      }
    })
 });



/*$('.crearProduccion').click(function(){

  var pedido_id =  $(this).parents("tr").find('.pedido_id').text()
  var cliente_id = $(this).parents("tr").find('.cliente').text()
  var descripcion = $(this).parents("tr").find('.descripcion').text()

  var infoPedido = '<tr><td>'+cliente_id+'</td><td>'+descripcion+'</td></tr>'

  $('#agregarPedido').html(infoPedido);

  $.ajax({

      url:'/info_produccion',
      data:{id:pedido_id},
      method:'get',
      success: function(data){

        console.log(data);
        var data_length = data.length

        for (var i = 0; i < data_length; i++) {

        }




      },
      error: function (request, status, error) {

    }
    })
/*
var pedido_id = $('#pedido_id').val();
toastr.warning(pedido_id)
var numero_de_orden = $('#numero_de_orden').val()
toastr.warning(numero_de_orden)
var descripcion = $('descripcion').val()
toastr.warning(descripcion)
*/


/*})*/

/*$('.crearOrden').click(function(){

  var pedido_id = $('#pedido_id').val();
  pedido_id = parseInt(pedido_id);
  var numero_de_orden = $('#numero_de_orden').val()
  var descripcion = $('#descripcion').val()
  var this_data ={

        pedido_id:pedido_id,
        numero_de_orden:numero_de_orden,
        descripcion:descripcion

  }
/*  Session dump
_csrf_token: "NGOAeZ6Jbt30S1JDdZLPeWghetgyIpP97pjFtZcpjnc="
session_id: "6c55f89f6cd2f70104384d17c4782e5d"
warden.user.user.key: [[1], "$2a$11$MXstTWkpcuh3F9KB8vCBc."]*/
  // POST /ordenes_de_produccion
/*  var create_new = '/crearNuevaOrden.json';
  $.ajax({
    url:create_new,
    method:'POST',
    data:{
      orden_de_produccion: {
      pedido_id:pedido_id,
      numero_de_orden:numero_de_orden,
      descripcion:descripcion }
    },
    success: function(data){
      data.preventDefault();
      toastr.success(data)
    },
    error: function(data){
      toastr.error(data)
    }

    })

});
*/



});
