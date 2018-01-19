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
//= require bootstrap-toggle
//= require moment
//= require moment/es.js
//= require select2
//= require toastr
//= require best_in_place
//= require jquery.purr
//= require best_in_place.purr
//= require jquery-ui
//= require best_in_place.jquery-ui
//= require_tree .




$(document).on('turbolinks:load', function() {


  $(".js-example-data-ajax").select2({
  ajax: {
    url: "/tintas.json",
    dataType: 'json',
    delay: 250,
    processResults: function (data, params) {
      // parse the results into the format expected by Select2
      // since we are using custom formatting functions we do not need to
      // alter the remote JSON data, except to indicate that infinite
      // scrolling can be used
      console.log(data);
    },
    cache: true
  },
  placeholder: 'Buscar Tinta',
  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
  minimumInputLength: 1,
  templateResult: formatRepo,
  templateSelection: formatRepoSelection
});

function formatRepo (repo) {

  if (repo.loading) {
    return repo.text;
  }

  var markup = "<div class='select2-result-repository clearfix'>" +
    "<div class='select2-result-repository__avatar'><img src='" + repo + "' /></div>" +
    "<div class='select2-result-repository__meta'>" +
      "<div class='select2-result-repository__title'>" + repo + "</div>";

  if (repo.description) {
    markup += "<div class='select2-result-repository__description'>" + repo + "</div>";
  }

  markup += "<div class='select2-result-repository__statistics'>" +
    "<div class='select2-result-repository__forks'><i class='fa fa-flash'></i> " + repo + " Forks</div>" +
    "<div class='select2-result-repository__stargazers'><i class='fa fa-star'></i> " + repo + " Stars</div>" +
    "<div class='select2-result-repository__watchers'><i class='fa fa-eye'></i> " + repo + " Watchers</div>" +
  "</div>" +
  "</div></div>";

  return markup;
}

function formatRepoSelection (repo) {
  return repo.full_name || repo.text;
}
















  if( $('#formato_op_tiro').prop('checked') ) {
    $('#div_tintas_tiro').show()
  }else {
    $('#div_tintas_tiro').hide()
  }


  if( $('#formato_op_retiro').prop('checked') ) {

    $('#div_tintas_retiro').show()
  }else {

    $('#div_tintas_retiro').hide()
  }


$("#formato_op_tiro").change(function(){


  if( $('#formato_op_tiro').prop('checked') ) {

    $('#div_tintas_tiro').show()
  }else {

    $('#div_tintas_tiro').hide()
  }


})


$("#formato_op_retiro").change(function(){


  if( $('#formato_op_retiro').prop('checked') ) {

    $('#div_tintas_retiro').show()
  }else {
    toastr.info("No Esta seleccionado")

  }


})





  $('form').on('click', '.remove_tintas_retiro', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();
    return event.preventDefault();
  });

  $('form').on('click', '.add_tintas_retiro', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_tintas_retiro').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });




  $('form').on('click', '.remove_tintas_tiro', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();
    return event.preventDefault();
  });

  $('form').on('click', '.add_tintas_tiro', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_tintas_tiro').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

//ordenes_produccion

$('#busqueda_fop').on("select2:select", function (e) {
  var fop_id = e.params.data.id;
  $.ajax({
    url:'/buscar_fop/'+fop_id+'.json',
    method:'get',
    success: function(data){

      var data_length = 1;

      for (var i = 0; i < data_length; i++) {

        var vendedor = data["user"]["nombre"];
        var montaje = data ["montaje"]["nombre"]
        var linea_producto = data ["linea_producto"]["nombre"]
        var maquina = data ["maquina"]["nombre"]
        var linea_de_color = data ["linea_de_color"]["nombre"]
        var material = data ["material"]
        var cliente_id = data ["montaje"]["cliente_id"]



        $('#op_vendedor').val(vendedor)
        $('#op_montaje').val(montaje)
        $('#op_linea_producto').val(linea_producto)
        $('#op_maquina').val(maquina)
        $('#op_linea_de_color').val(linea_de_color)
        $('#op_material').val(material)

        $.ajax({
          url:'/clientes/'+cliente_id+'.json',
          method:'get',
          success: function (data){
            var cliente_lentgh = 1;
            for (var i = 0; i < cliente_lentgh; i++) {

              var cliente = data ["nombre"]
              $('#op_cliente').val(cliente)

            }
          }
        })


      }

    }
  })
});







  $('.ocultar_fecha').hide()

  $('form').on('click', '.remove_piezas', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();
    return event.preventDefault();
  });

  $('form').on('click', '.add_piezas', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_piezas').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });


  /*------------------Validacion Pedidos Totales-------------------------*/


  $('#pedido_condicion_de_pedido').change(function(){
    var condicion_de_pedido=$('#pedido_condicion_de_pedido').val()
    if(condicion_de_pedido= 'Bajo Cotizacion'){
      $('#pedido_numero_cotizacion').prop('disabled', false);
    }else if (condicion_de_pedido= 'Bajo Pedido') {
      $('#pedido_numero_cotizacion').prop('disabled', true);
    }
  })

  $('#pedido_numero_cotizacion').focusout(function(){
    //var pedido_numero_cotizacion=$('#pedido_numero_cotizacion').val()
    //toastr.success('pedido_numero_de_pedido')
  })

  $('#pedido_numero_de_pedido').focusout(function(){

    var pedido_numero_de_pedido=$('#pedido_numero_de_pedido').val()
    if (pedido_numero_de_pedido==""){
      $('#pedido_numero_de_pedido').css("border", "1px solid #a94442")
      var campo_error='<span class="help-block" id="error_numero_de_pedido">El Número de pedido no debe estar vacío</span>'
      $('#campo_numero_de_pedido').html(campo_error)
      //alertify.error("El número de pedido debe estar vacio")
    }else{
      $('#pedido_numero_de_pedido').css("border", "1px solid #3c763d");
      $('#campo_numero_de_pedido').html("")
    }

  })

  $('#pedido_descripcion').focusout(function(){
    //var pedido_numero_cotizacion=$('#pedido_numero_cotizacion').val()
    var pedido_numero_de_pedido=$('#pedido_descripcion').val()
    if (pedido_numero_de_pedido==""){
      $('#pedido_descripcion').css("border", "1px solid #a94442")
      var campo_error='<span class="help-block" id="error_numero_de_pedido">La descripción del pedido no debe estar vacía</span>'
      $('#campo_descripcion_pedido').html(campo_error)
      //alertify.error("El número de pedido debe estar vacio")
    }else{
      $('#pedido_descripcion').css("border", "1px solid #3c763d");
      $('#campo_descripcion_pedido').html("")
    }
  })
  $('#fecha_de_pedido').focusout(function(){
    //var pedido_numero_cotizacion=$('#pedido_numero_cotizacion').val()
    var pedido_numero_de_pedido=$('#fecha_de_pedido').val()
    if (pedido_numero_de_pedido==""){
      $('#fecha_de_pedido').css("border", "1px solid #a94442")
      var campo_error='<span class="help-block" id="error_numero_de_pedido">La Fecha del pedido no debe estar vacía</span>'
      $('#campo_fecha_pedido').html(campo_error)
      //alertify.error("El número de pedido debe estar vacio")
    }else{
      $('#fecha_de_pedido').css("border", "1px solid #3c763d");
      $('#campo_fecha_pedido').html("")
    }
  })
  $('#pedido_linea_de_impresion_id').focusout(function(){
    //var pedido_numero_cotizacion=$('#pedido_numero_cotizacion').val()
    toastr.success('pedido_numero_de_pedido')
  })
  $('#pedido_forma_de_pago').focusout(function(){
    //var pedido_numero_cotizacion=$('#pedido_numero_cotizacion').val()
    toastr.success('pedido_numero_de_pedido')
  })
  $('#pedido_arte').focusout(function(){
    //var pedido_numero_cotizacion=$('#pedido_numero_cotizacion').val()
    toastr.success('pedido_numero_de_pedido')
  })
  $('#pedido_tipo_de_trabajo').focusout(function(){
    //var pedido_numero_cotizacion=$('#pedido_numero_cotizacion').val()
    toastr.success('pedido_numero_de_pedido')
  })


  $('.validacion_fecha').focusout(function (){
    //toastr.success("validate")
    var pedido_numero_de_pedido=$(this).parents("tr").find('.validacion_fecha').val()
    if (pedido_numero_de_pedido==""){
      $(this).parents("tr").find('.validacion_fecha').css("border", "1px solid #a94442")
      var campo_error='<span class="help-block" id="error_numero_de_pedido">La Fecha del Compromiso no debe estar vacía</span>'
      $(this).parents("tr").find('.campo_fecha_entrega').html(campo_error)
      //alertify.error("El número de pedido debe estar vacio")
    }else{
      $(this).parents("tr").find('.validacion_fecha').css("border", "1px solid #3c763d");
      $(this).parents("tr").find('.campo_fecha_entrega').html("")
    }
  })








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

  /*------------------Function Sumar Totales-------------------------*/
  var sumarTotalesPrecio= function(event){

    var total = 0;
    var cantInput = 1

    var contador=$("#entregas .precio").length
    contador = parseFloat(contador)

    for (var i = 0; i < contador; i++) {

      var valores = $('.precio:eq('+i+')').val()
      valores = parseFloat(valores)
      total = total + valores

      if (isNaN(total)) {

      } else {
        $("#precio_total").val(total)
      }

    }
  }


/*---------------------Ejecutar Function Sumar Totales al iniciar la pagina----------------------------*/
  $('.cantidad').focusout(function(event) {
    //toastr.success("focus Out")
    /*Fucntion Totales*/
      sumarTotales();
    /*/Function Totalse*/
  });

  $('.precio').focusout(function(event) {
    //toastr.success("focus Out")
    /*Fucntion Totales*/
      sumarTotalesPrecio();
    /*/Function Totalse*/
  });




    jQuery(".best_in_place").best_in_place();

  $('form').on('click', '.remove_contactos', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();
    return event.preventDefault();
  });

  $('form').on('click', '.add_contactos', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_contactos').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });





  $('#contenedor_Fecha_De_Pedido').hide()
  $('#fecha_de_pedido').focusout(function(){

    var this_fecha = $("#fecha_de_pedido").val();
    $("#pedido_fecha_de_pedido").val(this_fecha);

  })

  $('.ocultar_fecha').hide();


  $('.fecha').focusout(function(){

    var this_fecha = $(this).parents("tr").find(".fecha").val();
    $(this).parents("tr").find(".my_fecha").val(this_fecha);
    var validar_fecha = $(this).parents("tr").find(".my_fecha").val();
  })

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
    sumarTotales();
    sumarTotalesPrecio();
    return event.preventDefault();
  });

  $('form').on('click', '.add_entregas', function(event) {

    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');

    $('.fields_entrega').append($(this).data('fields').replace(regexp, time));
    $('.ocultar_fecha').hide();

    $('.fecha').focusout(function(){
      //toastr.success("Fecha FocusOut")
      var this_fecha = $(this).parents("tr").find(".fecha").val();
      $(this).parents("tr").find(".my_fecha").val(this_fecha);
      var validar_fecha = $(this).parents("tr").find(".my_fecha").val();
    })

    //validar Fecha
    $('.validacion_fecha').focusout(function (){
      //toastr.success("validate")
      var pedido_numero_de_pedido=$(this).parents("tr").find('.validacion_fecha').val()
      if (pedido_numero_de_pedido==""){
        $(this).parents("tr").find('.validacion_fecha').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">La Fecha del Compromiso no debe estar vacía</span>'
        $(this).parents("tr").find('.campo_fecha_entrega').html(campo_error)
        //alertify.error("El número de pedido debe estar vacio")
      }else{
        $(this).parents("tr").find('.validacion_fecha').css("border", "1px solid #3c763d");
        $(this).parents("tr").find('.campo_fecha_entrega').html("")
      }
    })
    /*---------------------Ejecutar Function Sumar Totales al iniciar la pagina----------------------------*/
      $('.cantidad').focusout(function(event) {
        //toastr.success("focus Out")
        /*Fucntion Totales*/
          sumarTotales();
        /*/Function Totalse*/
      });

      $('.precio').focusout(function(event) {
        //toastr.success("focus Out")
        /*Fucntion Totales*/
          sumarTotalesPrecio();
        /*/Function Totalse*/
      });
    return event.preventDefault();
  });

  $('form').on('click', '.remove_remisiones', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();
    return event.preventDefault();
  });

  $('form').on('click', '.add_remisiones', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_remisiones').append($(this).data('fields').replace(regexp, time));
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
warden.user.user.key: [[1], "$2a$11$MXstTWkpcuh3F9KB8vCBClientes
c."]*/
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


/*! ========================================================================
 * Bootstrap Toggle: bootstrap-toggle.js v2.2.0
 * http://www.bootstraptoggle.com
 * ========================================================================
 * Copyright 2014 Min Hur, The New York Times Company
 * Licensed under MIT
 * ======================================================================== */
+function(a){"use strict";function b(b){return this.each(function(){var d=a(this),e=d.data("bs.toggle"),f="object"==typeof b&&b;e||d.data("bs.toggle",e=new c(this,f)),"string"==typeof b&&e[b]&&e[b]()})}var c=function(b,c){this.$element=a(b),this.options=a.extend({},this.defaults(),c),this.render()};c.VERSION="2.2.0",c.DEFAULTS={on:"On",off:"Off",onstyle:"primary",offstyle:"default",size:"normal",style:"",width:null,height:null},c.prototype.defaults=function(){return{on:this.$element.attr("data-on")||c.DEFAULTS.on,off:this.$element.attr("data-off")||c.DEFAULTS.off,onstyle:this.$element.attr("data-onstyle")||c.DEFAULTS.onstyle,offstyle:this.$element.attr("data-offstyle")||c.DEFAULTS.offstyle,size:this.$element.attr("data-size")||c.DEFAULTS.size,style:this.$element.attr("data-style")||c.DEFAULTS.style,width:this.$element.attr("data-width")||c.DEFAULTS.width,height:this.$element.attr("data-height")||c.DEFAULTS.height}},c.prototype.render=function(){this._onstyle="btn-"+this.options.onstyle,this._offstyle="btn-"+this.options.offstyle;var b="large"===this.options.size?"btn-lg":"small"===this.options.size?"btn-sm":"mini"===this.options.size?"btn-xs":"",c=a('<label class="btn">').html(this.options.on).addClass(this._onstyle+" "+b),d=a('<label class="btn">').html(this.options.off).addClass(this._offstyle+" "+b+" active"),e=a('<span class="toggle-handle btn btn-default">').addClass(b),f=a('<div class="toggle-group">').append(c,d,e),g=a('<div class="toggle btn" data-toggle="toggle">').addClass(this.$element.prop("checked")?this._onstyle:this._offstyle+" off").addClass(b).addClass(this.options.style);this.$element.wrap(g),a.extend(this,{$toggle:this.$element.parent(),$toggleOn:c,$toggleOff:d,$toggleGroup:f}),this.$toggle.append(f);var h=this.options.width||Math.max(c.outerWidth(),d.outerWidth())+e.outerWidth()/2,i=this.options.height||Math.max(c.outerHeight(),d.outerHeight());c.addClass("toggle-on"),d.addClass("toggle-off"),this.$toggle.css({width:h,height:i}),this.options.height&&(c.css("line-height",c.height()+"px"),d.css("line-height",d.height()+"px")),this.update(!0),this.trigger(!0)},c.prototype.toggle=function(){this.$element.prop("checked")?this.off():this.on()},c.prototype.on=function(a){return this.$element.prop("disabled")?!1:(this.$toggle.removeClass(this._offstyle+" off").addClass(this._onstyle),this.$element.prop("checked",!0),void(a||this.trigger()))},c.prototype.off=function(a){return this.$element.prop("disabled")?!1:(this.$toggle.removeClass(this._onstyle).addClass(this._offstyle+" off"),this.$element.prop("checked",!1),void(a||this.trigger()))},c.prototype.enable=function(){this.$toggle.removeAttr("disabled"),this.$element.prop("disabled",!1)},c.prototype.disable=function(){this.$toggle.attr("disabled","disabled"),this.$element.prop("disabled",!0)},c.prototype.update=function(a){this.$element.prop("disabled")?this.disable():this.enable(),this.$element.prop("checked")?this.on(a):this.off(a)},c.prototype.trigger=function(b){this.$element.off("change.bs.toggle"),b||this.$element.change(),this.$element.on("change.bs.toggle",a.proxy(function(){this.update()},this))},c.prototype.destroy=function(){this.$element.off("change.bs.toggle"),this.$toggleGroup.remove(),this.$element.removeData("bs.toggle"),this.$element.unwrap()};var d=a.fn.bootstrapToggle;a.fn.bootstrapToggle=b,a.fn.bootstrapToggle.Constructor=c,a.fn.toggle.noConflict=function(){return a.fn.bootstrapToggle=d,this},a(function(){a("input[type=checkbox][data-toggle^=toggle]").bootstrapToggle()}),a(document).on("click.bs.toggle","div[data-toggle^=toggle]",function(b){var c=a(this).find("input[type=checkbox]");c.bootstrapToggle("toggle"),b.preventDefault()})}(jQuery);
//# sourceMappingURL=bootstrap-toggle.min.js.map
});
