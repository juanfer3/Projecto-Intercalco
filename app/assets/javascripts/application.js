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
//= require jquery.purr
//= require best_in_place.purr
//= require jquery-ui
//= require best_in_place.jquery-ui
//= require_tree .




$(document).on('turbolinks:load', function() {


  $('#buscador_montajes').keyup(function(){
    var data=$('#buscador_montajes').val()
    $.ajax({
      url:'/buscador_de_fichas/',
      data: {data:data},
      method:'get',
      success: function (data){
        console.log();

      }
    })
  })


  $('#buscar_orden').keyup(function(){
    var data=$('#buscar_orden').val()
    $.ajax({
      url:'/buscador_de_ordenes/',
      data: {data:data},
      method:'get',
      success: function (data){
        console.log();

      }
    })
  })

  //////////////////////////////////////////////////////////////


  $(".multiSelect").select2({
    tags: true,
    tokenSeparators: [',', ' ']
})

//ordenes=============================================================================

$('#contenedorBtnOrden').hide()
$('form').on('click', '.remove_ordenes', function(event) {
  $('#ContenedorDeOrdenes').html("")
  $('#contenedorBtnOrden').show()
  $('#contenedorBtnOrdenEliminar').hide()
  return event.preventDefault();
});

$('form').on('click', '.add_ordenes', function(event) {

    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('#ContenedorDeOrdenes').append($(this).data('fields').replace(regexp, time));
    $("#ordenes_quitar_poner").removeClass('add_ordenes')
    $('#contenedorBtnOrden').hide()
    $('#contenedorBtnOrdenEliminar').show()
    return event.preventDefault();



});
/*
if( $('#crearOrden').prop('checked') ) {

  $("#ContenedorDeOrdenes").show()

}else {

  $("#ContenedorDeOrdenes").hide()
}

$("#crearOrden").change(function(){

  if( $('#crearOrden').prop('checked') ) {

    $("#ContenedorDeOrdenes").show()

  }else {

    $("#ContenedorDeOrdenes").hide()
  }

})
*/

$('#select_cliente_montaje').select2().select2('val', $('#select_cliente_montaje option:eq(1)').val());
$('#select_material').select2().select2('val', $('#select_material option:eq(1)').val());

//$('#select_malla > option[value="<%=@desarrollo_de_tinta.malla.id%>"]').attr('selected', 'selected');

  //$('#btnDesarrollo').trigger('click');




  if( $('#crearMaterial').prop('checked') ) {

    $('.ContenedorMaterialNuevo').show()
    $('#contenedorMaterialExistente').hide();
  }else {

    $('#contenedorMaterialExistente').show()

    $(".ContenedorMaterialNuevo").hide()
  }


  $("#crearMaterial").change(function(){

    if( $('#crearMaterial').prop('checked') ) {

      $('.ContenedorMaterialNuevo').show()

      $('#contenedorMaterialExistente').hide();
    }else {

      $('#contenedorMaterialExistente').show()
      $('#montaje_material_nuevo').val("")
      $(".ContenedorMaterialNuevo").hide()
    }

  })





  if( $('#crearCliente').prop('checked') ) {

    $('.ContenedorClienteNuevo').show()
    $('#contenedorClienteExistente').hide();
  }else {

    $('#contenedorClienteExistente').show()
    $('#vendedor_cliente_nuevo').addClass('form-control')
    $(".ContenedorClienteNuevo").hide()
  }


  $("#crearCliente").change(function(){

    if( $('#crearCliente').prop('checked') ) {

      $('.ContenedorClienteNuevo').show()
      $('#vendedor_cliente_nuevo').addClass("form-control")
      $('#contenedorClienteExistente').hide();
    }else {

      $('#contenedorClienteExistente').show()
      $('#montaje_new_cliente').val("")
      $(".ContenedorClienteNuevo").hide()
    }

  })





  $("#checkbox_policromia").change(function (){
    if ($("#checkbox_policromia").prop('checked')) {
      for (var i = 0; i < 3; i++) {
        $('#btnDesarrollo').trigger('click');
      }

      var contador_de_policromias = $("#CamposDesarrollo .js-example-tintas").length

      contador_de_policromias = parseFloat(contador_de_policromias)
      for (var i = 0; i < contador_de_policromias; i++) {

        switch(i) {
              case 0:
                  $('.js-example-tintas:eq('+i+') ').val("CYAN").trigger('change');
                  break;
              case 1:
                  $('.js-example-tintas:eq('+i+') ').val("MAGENTA").trigger('change');
                  break;
              case 2:
                  $('.js-example-tintas:eq('+i+') ').val("YELLOW").trigger('change');
                  break;
              case 3:
                $('.js-example-tintas:eq('+i+') ').val("NEGRO").trigger('change');
                break;

          }

      }
    }else {
      $('#ContenedorDesarrollo').html("")
      $('#btnDesarrollo').trigger('click');
    }

  })



  $("#montaje_ordenes_produccion_attributes_0_cantidad_hoja").focusout(function(){

    var cantidad_hojas= $("#montaje_ordenes_produccion_attributes_0_cantidad_hoja").val()
    var tamano_por_hojas = $("#montaje_tamano_por_hojas").val()
    if (cantidad_hojas.length <= 0 && tamano_por_hojas.length <= 0) {

      }

      else {

        cantidad_hojas = parseFloat(cantidad_hojas)


        tamano_por_hojas = parseFloat(tamano_por_hojas)


        var tamanos_total = cantidad_hojas * tamano_por_hojas

        $("#montaje_ordenes_produccion_attributes_0_tamanos_total").val(tamanos_total)





        var tama_total= $("#montaje_ordenes_produccion_attributes_0_tamanos_total").val()
        var cavidad = $("#montaje_ordenes_produccion_attributes_0_cavidad").val()
        if (tama_total.length <= 0 && cavidad.length <=0) {


        }

        else {

          tama_total = parseFloat(tama_total)


          cavidad = parseFloat(cavidad)


          var cantidad_total = tama_total * cavidad

          $("#montaje_ordenes_produccion_attributes_0_cantidad_programada").val(cantidad_total)
        }


      }




  })



  $("#montaje_tamano_por_hojas").focusout(function(){

    var cantidad_hojas= $("#montaje_ordenes_produccion_attributes_0_cantidad_hoja").val()
    var tamano_por_hojas = $("#montaje_tamano_por_hojas").val()
    if (cantidad_hojas.length <= 0 && tamano_por_hojas.length <=0) {


    }

    else {

      cantidad_hojas = parseFloat(cantidad_hojas)


      tamano_por_hojas = parseFloat(tamano_por_hojas )


      var tamanos_total = cantidad_hojas * tamano_por_hojas

      $("#montaje_ordenes_produccion_attributes_0_tamanos_total").val(tamanos_total)
      var tama_total= $("#montaje_ordenes_produccion_attributes_0_tamanos_total").val()
      var cavidad = $("#montaje_ordenes_produccion_attributes_0_cavidad").val()
      if (tama_total.length <= 0 && cavidad.length <=0) {


      }

      else {

        tama_total = parseFloat(tama_total)


        cavidad = parseFloat(cavidad)


        var cantidad_total = tama_total * cavidad

        $("#montaje_ordenes_produccion_attributes_0_cantidad_programada").val(cantidad_total)
      }

    }






  })


  $("#montaje_ordenes_produccion_attributes_0_tamanos_total").focusout(function(){

    var tama_total= $("#montaje_ordenes_produccion_attributes_0_tamanos_total").val()
    var cavidad = $("#montaje_ordenes_produccion_attributes_0_cavidad").val()
    if (tama_total.length <= 0 && cavidad.length <=0) {


    }

    else {

      tama_total = parseFloat(tama_total)


      cavidad = parseFloat(cavidad)


      var cantidad_total = tama_total * cavidad

      $("#montaje_ordenes_produccion_attributes_0_cantidad_programada").val(cantidad_total)
    }






  })


  $("#montaje_ordenes_produccion_attributes_0_cavidad").focusout(function(){

    var tama_total= $("#montaje_ordenes_produccion_attributes_0_tamanos_total").val()
    var cavidad = $("#montaje_ordenes_produccion_attributes_0_cavidad").val()
    if (tama_total.length <= 0 && cavidad.length <=0) {


    }

    else {

      tama_total = parseFloat(tama_total)


      cavidad = parseFloat(cavidad)


      var cantidad_total = tama_total * cavidad

      $("#montaje_ordenes_produccion_attributes_0_cantidad_programada").val(cantidad_total)
    }






  })











  //============================================================================================================

  $("#orden_produccion_cantidad_hoja").focusout(function(){

    var cantidad_hojas= $("#orden_produccion_cantidad_hoja").val()
    var tamano_por_hojas = $("#op_tamano_hoja").val()
    if (cantidad_hojas.length <= 0 && tamano_por_hojas.length <= 0) {

      }

      else {

        cantidad_hojas = parseFloat(cantidad_hojas)


        tamano_por_hojas = parseFloat(tamano_por_hojas )


        var tamanos_total = cantidad_hojas * tamano_por_hojas

        $("#orden_produccion_tamanos_total").val(tamanos_total)
        var tama_total= $("#orden_produccion_tamanos_total").val()
        var cavidad = $("#orden_produccion_cavidad").val()
        if (tama_total.length <= 0 && cavidad.length <=0) {


        }

        else {

          tama_total = parseFloat(tama_total)


          cavidad = parseFloat(cavidad)


          var cantidad_total = tama_total * cavidad

          $("#orden_produccion_cantidad_programada").val(cantidad_total)
        }


      }




  })



  $("#orden_produccion_tamano_por_hojas").focusout(function(){

    var cantidad_hojas= $("#orden_produccion_cantidad_hoja").val()
    var tamano_por_hojas = $("#orden_produccion_tamano_por_hojas").val()
    if (cantidad_hojas.length <= 0 && tamano_por_hojas.length <=0) {


    }

    else {

      cantidad_hojas = parseFloat(cantidad_hojas)


      tamano_por_hojas = parseFloat(tamano_por_hojas )


      var tamanos_total = cantidad_hojas * tamano_por_hojas

      $("#orden_produccion_tamanos_total").val(tamanos_total)

      var tama_total= $("#orden_produccion_tamanos_total").val()
      var cavidad = $("#orden_produccion_cavidad").val()
      if (tama_total.length <= 0 && cavidad.length <=0) {


      }

      else {

        tama_total = parseFloat(tama_total)


        cavidad = parseFloat(cavidad)


        var cantidad_total = tama_total * cavidad

        $("#orden_produccion_cantidad_programada").val(cantidad_total)
      }




    }






  })


  $("#orden_produccion_tamanos_total").focusout(function(){

    var tama_total= $("#orden_produccion_tamanos_total").val()
    var cavidad = $("#orden_produccion_cavidad").val()
    if (tama_total.length <= 0 && cavidad.length <=0) {


    }

    else {

      tama_total = parseFloat(tama_total)


      cavidad = parseFloat(cavidad)


      var cantidad_total = tama_total * cavidad

      $("#orden_produccion_cantidad_programada").val(cantidad_total)
    }






  })


  $("#orden_produccion_cavidad").focusout(function(){

    var tama_total= $("#orden_produccion_tamanos_total").val()
    var cavidad = $("#orden_produccion_cavidad").val()
    if (tama_total.length <= 0 && cavidad.length <=0) {


    }

    else {

      tama_total = parseFloat(tama_total)


      cavidad = parseFloat(cavidad)


      var cantidad_total = tama_total * cavidad

      $("#orden_produccion_cantidad_programada").val(cantidad_total)
    }






  })


  $('form').keypress(function(e){
    if(e == 13){
      return false;
    }
  });

  $('input').keypress(function(e){
    if(e.which == 13){
      return false;
    }
  });


  $("#compromiso_de_entrega_enviado").attr('checked',true);

  $("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").focusout(function(){

      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      if (linea_pieza=="") {
        $('#montaje_formatos_op_attributes_0_pieza_a_decorar_id').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">Debe seleccionar la pieza a decorar</span>'
        $('#campo_pieza').html(campo_error)

      }else{

        $('#montaje_formatos_op_attributes_0_pieza_a_decorar_id').css("border", "1px solid #3c763d");
        $('#campo_pieza').html("")

      }
      var valor =$("#montaje_nombre").val()
      var montaje =$("#montaje_codigo").val()
      var user =$("#montaje_user_id").val()
      var cliente =$("#montaje_cliente_id").val()


      var linea_producto =$("#montaje_formatos_op_attributes_0_linea_producto_id").val()
      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      var linea_maquina =$("#montaje_formatos_op_attributes_0_maquina_id").val()
      var linea_color =$("#montaje_formatos_op_attributes_0_linea_de_color_id").val()

      if (montaje == "" || valor=="" || user== "" || cliente =="" ||
      linea_producto=="" || linea_color==""|| linea_maquina== ""|| linea_pieza=="") {
        $('#btn-montaje').attr('disabled','disabled');
      }else {
        $('#btn-montaje').prop('disabled', false);
      }

  })

  $("#montaje_formatos_op_attributes_0_maquina_id").focusout(function(){

      var linea_maquina =$("#montaje_formatos_op_attributes_0_maquina_id").val()
      if (linea_maquina=="") {
        $('#montaje_formatos_op_attributes_0_maquina_id').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">Debe Selecionar la máquina</span>'
        $('#campo_maquina').html(campo_error)

      }else{

        $('#montaje_formatos_op_attributes_0_maquina_id').css("border", "1px solid #3c763d");
        $('#campo_maquina').html("")

      }
      var valor =$("#montaje_nombre").val()
      var montaje =$("#montaje_codigo").val()
      var user =$("#montaje_user_id").val()
      var cliente =$("#montaje_cliente_id").val()

      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      var linea_producto =$("#montaje_formatos_op_attributes_0_linea_producto_id").val()
      var linea_color =$("#montaje_formatos_op_attributes_0_linea_de_color_id").val()


      if (montaje == "" || valor=="" || user== "" || cliente =="" ||
      linea_producto=="" || linea_color==""|| linea_maquina== ""|| linea_pieza=="" ) {
        $('#btn-montaje').attr('disabled','disabled');
      }else {
        $('#btn-montaje').prop('disabled', false);
      }

  })



  $("#montaje_formatos_op_attributes_0_linea_de_color_id").focusout(function(){

      var linea_color =$("#montaje_formatos_op_attributes_0_linea_de_color_id").val()
      if (linea_color=="") {
        $('#montaje_formatos_op_attributes_0_linea_de_color_id').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">Debe seleccionar la línea de color</span>'
        $('#campo_lineaColor').html(campo_error)

      }else{

        $('#montaje_formatos_op_attributes_0_linea_de_color_id').css("border", "1px solid #3c763d");
        $('#campo_lineaColor').html("")

      }
      var valor =$("#montaje_nombre").val()
      var montaje =$("#montaje_codigo").val()
      var user =$("#montaje_user_id").val()
      var cliente =$("#montaje_cliente_id").val()

      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      var linea_producto =$("#montaje_formatos_op_attributes_0_linea_producto_id").val()

      var linea_maquina =$("#montaje_formatos_op_attributes_0_maquina_id").val()

      if (montaje == "" || valor=="" || user== "" || cliente =="" ||
      linea_producto=="" || linea_color==""|| linea_maquina== ""|| linea_pieza=="") {
        $('#btn-montaje').attr('disabled','disabled');
      }else {
        $('#btn-montaje').prop('disabled', false);
      }

  })

  $("#montaje_formatos_op_attributes_0_linea_producto_id").focusout(function(){

      var linea_producto =$("#montaje_formatos_op_attributes_0_linea_producto_id").val()
      if (linea_producto=="") {
        $('#montaje_formatos_op_attributes_0_linea_producto_id').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">Debe seleccionar la línea de producto</span>'
        $('#campo_productos').html(campo_error)

      }else{

        $('#montaje_formatos_op_attributes_0_linea_producto_id').css("border", "1px solid #3c763d");
        $('#campo_productos').html("")

      }
      var valor =$("#montaje_nombre").val()
      var montaje =$("#montaje_codigo").val()
      var user =$("#montaje_user_id").val()
      var cliente =$("#montaje_cliente_id").val()



      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      var linea_maquina =$("#montaje_formatos_op_attributes_0_maquina_id").val()
      var linea_color =$("#montaje_formatos_op_attributes_0_linea_de_color_id").val()

      if (montaje == "" || valor=="" || user== "" || cliente =="" ||
      linea_producto=="" || linea_color==""|| linea_maquina== ""|| linea_pieza=="") {
        $('#btn-montaje').attr('disabled','disabled');
      }else {
        $('#btn-montaje').prop('disabled', false);
      }

  })

  $("#montaje_nombre").focusout(function(){

      var valor =$("#montaje_nombre").val()
      if (valor=="") {
        $('#montaje_nombre').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">El campo de la descripción no puede estar vacio</span>'
        $('#campo_nombre').html(campo_error)

      }else{

        $('#montaje_nombre').css("border", "1px solid #3c763d");
        $('#campo_nombre').html("")

      }

      var montaje =$("#montaje_codigo").val()
      var user =$("#montaje_user_id").val()
      var cliente =$("#montaje_cliente_id").val()

      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      var linea_producto =$("#montaje_formatos_op_attributes_0_linea_producto_id").val()
      var linea_color =$("#montaje_formatos_op_attributes_0_linea_de_color_id").val()
      var linea_maquina =$("#montaje_formatos_op_attributes_0_maquina_id").val()

      if (montaje == "" || valor=="" || user== "" || cliente =="" ||
      linea_producto=="" || linea_color==""|| linea_maquina== ""|| linea_pieza=="") {
        $('#btn-montaje').attr('disabled','disabled');
      }else {
        $('#btn-montaje').prop('disabled', false);
      }

  })

  $("#montaje_codigo").focusout(function(){
      var user =$("#montaje_codigo").val()
      if (user=="") {
        $('#montaje_codigo').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">El campo del codigo no puede estar vacio</span>'
        $('#campo_codigo').html(campo_error)
        $('#btn-montaje').attr('disabled','disabled');
      }else{

        $('#montaje_codigo').css("border", "1px solid #3c763d");
        $('#campo_codigo').html("")
      }

      var montaje =$("#montaje_codigo").val()
      var valor =$("#montaje_nombre").val()
      var cliente =$("#montaje_cliente_id").val()

      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      var linea_producto =$("#montaje_formatos_op_attributes_0_linea_producto_id").val()
      var linea_pieza =$("#montaje_formatos_op_attributes_0_pieza_a_decorar_id").val()
      var linea_maquina =$("#montaje_formatos_op_attributes_0_maquina_id").val()

      if (montaje == "" || valor=="" || user== "" || cliente =="" ||
      linea_producto=="" || linea_color==""|| linea_maquina== ""|| linea_pieza=="") {
        $('#btn-montaje').attr('disabled','disabled');
      }else {
        $('#btn-montaje').prop('disabled', false);
      }

  })

  $("#montaje_user_id").focusout(function(){
      var user =$("#montaje_user_id").val()
      if (user=="") {
        $('#montaje_user_id').css("border", "1px solid #a94442")
        var campo_error='<span class="help-block" id="error_numero_de_pedido">Debe Seleccionar Un Vendedor</span>'
        $('#campo_user').html(campo_error)
        $('#btn-montaje').attr('disabled','disabled');
      }else{

        $('#montaje_user_id').css("border", "1px solid #3c763d");
        $('#campo_user').html("")
      }
  })


$("#montaje_cliente_id").focusout(function(){
    var cliente =$("#montaje_cliente_id").val()
    if (cliente=="") {
      $('#montaje_cliente_id').css("border", "1px solid #a94442")
      var campo_error='<span class="help-block" id="error_numero_de_pedido">Debe Seleccionar Un Cliente</span>'
      $('#campo_cliente').html(campo_error)
      $('#btn-montaje').attr('disabled','disabled');
    }else{

      $('#montaje_cliente_id').css("border", "1px solid #3c763d");
      $('#campo_cliente').html("")
    }
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




//================================!!!!!!!!!!!!!!!!!!!!!=========================
$('#contenedorDesarrolloTintas').hide()
if( $('#montaje_tinta_nueva').prop('checked') ) {

  $('#contenedorDesarrolloTintas').show()
  $('#btnDesarrollo').trigger('click');
}else {

  $('#contenedorDesarrolloTintas').hide()
  $(".contenedor_tinta_nueva").remove()
}

$('#montaje_tinta_nueva').change(function(){

  if( $('#montaje_tinta_nueva').prop('checked') ) {

    $('#contenedorDesarrolloTintas').show()
    $('#btnDesarrollo').trigger('click');
  }else {

    $('#contenedorDesarrolloTintas').hide()
    $(".contenedor_tinta_nueva").remove()
  }

})








  $("#montaje_doming").attr('checked',true);
  $("#montaje_doming").change(function(){

    if( $('#montaje_doming').prop('checked') ) {

      $('#origenDoming').show()
      $('#contenedorDoming').appendTo('#origenDoming');
      $('#contenedorDoming').removeClass( "col-2" )

    }else {

      $('#contenedorDoming').appendTo('#EstadosFalse');
      $('#contenedorDoming').addClass( "col-2" );
      $('#origenDoming').hide()

    }

  })


  $("#montaje_plotter").attr('checked',true);
  $("#montaje_plotter").change(function(){

    if( $('#montaje_plotter').prop('checked') ) {

      $('#origenPlotter').show()
      $('#contenedorPlotter').appendTo('#origenPlotter');
      $('#contenedorPlotter').removeClass( "col-2" )

    }else {

      $('#contenedorPlotter').appendTo('#EstadosFalse');
      $('#contenedorPlotter').addClass( "col-2" );
      $('#origenPlotter').hide()

    }

  })

  $("#montaje_descalerillado").attr('checked',true);
  $("#montaje_descalerillado").change(function(){

    if( $('#montaje_descalerillado').prop('checked') ) {

      $('#origenDescalerillado').show()
      $('#contenedorDescalerillado').appendTo('#origenDescalerillado');
      $('#contenedorDescalerillado').removeClass( "col-2" )

    }else {

      $('#contenedorDescalerillado').appendTo('#EstadosFalse');
      $('#contenedorDescalerillado').addClass( "col-2" );
      $('#origenDescalerillado').hide()

    }

  })


  $("#montaje_troquelado").attr('checked',true);
  $("#montaje_troquelado").change(function(){

    if( $('#montaje_troquelado').prop('checked') ) {

      $('#origenTroquelado').show()
      $('#contenedorTroquelado').appendTo('#origenTroquelado');
      $('#contenedorTroquelado').removeClass( "col-2" )

    }else {

      $('#contenedorTroquelado').appendTo('#EstadosFalse');
      $('#contenedorTroquelado').addClass( "col-2" );
      $('#origenTroquelado').hide()

    }

  })
  $("#montaje_laminado").attr('checked',true);
  $("#montaje_laminado").change(function(){

    if( $('#montaje_laminado').prop('checked') ) {

      $('#origenLaminado').show()
      $('#contenedorLaminado').appendTo('#origenLaminado');
      $('#contenedorLaminado').removeClass( "col-2" )

    }else {

      $('#contenedorLaminado').appendTo('#EstadosFalse');
      $('#contenedorLaminado').addClass( "col-2" );
      $('#origenLaminado').hide()

    }

  })

  $("#montaje_pretroquelado").attr('checked',true);
  $("#montaje_pretroquelado").change(function(){

    if( $('#montaje_pretroquelado').prop('checked') ) {

      $('#origenPretroquelado').show()
      $('#contenedorPretroquelado').appendTo('#origenPretroquelado');
      $('#contenedorPretroquelado').removeClass( "col-2" )

    }else {


      $('#contenedorPretroquelado').appendTo('#EstadosFalse');
      $('#contenedorPretroquelado').addClass( "col-2" );
      $('#origenPretroquelado').hide()




    }

  })
  $("#montaje_precorte").attr('checked',true);
  $("#montaje_precorte").change(function(){

    if( $('#montaje_precorte').prop('checked') ) {

      $('#origenPrecorte').show()
      $('#contenedorPrecorte').appendTo('#origenPrecorte');
      $('#contenedorPrecorte').removeClass( "col-2" )

    }else {

      $('#contenedorPrecorte').appendTo('#EstadosFalse');
      $('#contenedorPrecorte').addClass( "col-2" );
      $('#origenPrecorte').hide()




    }

  })


  $("#montaje_ensamblado").change(function(){

    if( $('#montaje_ensamblado').prop('checked') ) {

      $('#contenedorEnsamblado').appendTo('#contenedorEstado');
      $('#contenedorEnsamblado').addClass( "col-2" );
      $('#origenEnsamblado').hide()
    }else {
      $('#origenEnsamblado').show()
      $('#contenedorEnsamblado').appendTo('#origenEnsamblado');
      $('#contenedorEnsamblado').removeClass( "col-2" )
    }

  })




  $("#montaje_ensamblado").change(function(){

    if( $('#montaje_ensamblado').prop('checked') ) {

      $('#contenedorEnsamblado').appendTo('#contenedorEstado');
      $('#contenedorEnsamblado').addClass( "col-2" );
      $('#origenEnsamblado').hide()
    }else {
      $('#origenEnsamblado').show()
      $('#contenedorEnsamblado').appendTo('#origenEnsamblado');
      $('#contenedorEnsamblado').removeClass( "col-2" )
    }

  })


  $("#montaje_pegado").change(function(){

    if( $('#montaje_pegado').prop('checked') ) {

      $('#contenedorPegado').appendTo('#contenedorEstado');
      $('#contenedorPegado').addClass( "col-2" );
      $('#origenPegado').hide()
    }else {
      $('#origenPegado').show()
      $('#contenedorPegado').appendTo('#origenPegado');
      $('#contenedorPegado').removeClass( "col-2" )
    }

  })


  $("#montaje_hilo").change(function(){

    if( $('#montaje_hilo').prop('checked') ) {

      $('#contenedorHilo').appendTo('#contenedorEstado');
      $('#contenedorHilo').addClass( "col-2" );
      $('#origenHilo').hide()
    }else {
      $('#origenHilo').show()
      $('#contenedorHilo').appendTo('#origenHilo');
      $('#contenedorHilo').removeClass( "col-2" )
    }

  })


  $("#montaje_ojalete").change(function(){

    if( $('#montaje_ojalete').prop('checked') ) {

      $('#contenedorOjalete').appendTo('#contenedorEstado');
      $('#contenedorOjalete').addClass( "col-2" );
      $('#origenOjalete').hide()
    }else {
      $('#origenOjalete').show()
      $('#contenedorOjalete').appendTo('#origenOjalete');
      $('#contenedorOjalete').removeClass( "col-2" )
    }

  })



  $("#montaje_perforado").change(function(){

    if( $('#montaje_perforado').prop('checked') ) {

      $('#contenedorPerforado').appendTo('#contenedorEstado');
      $('#contenedorPerforado').addClass( "col-2" );
      $('#origenPerforado').hide()
    }else {
      $('#origenPerforado').show()
      $('#contenedorPerforado').appendTo('#origenPerforado');
      $('#contenedorPerforado').removeClass( "col-2" )
    }

  })





  $("#montaje_refilado").change(function(){

    if( $('#montaje_refilado').prop('checked') ) {

      $('#contenedorRefilado').appendTo('#contenedorEstado');
      $('#contenedorRefilado').addClass( "col-2" );
      $('#origenRefilado').hide()
    }else {
      $('#origenRefilado').show()
      $('#contenedorRefilado').appendTo('#origenRefilado');
      $('#contenedorRefilado').removeClass( "col-2" )
    }

  })






  $("#montaje_estampado_al_calor").change(function(){

    if( $('#montaje_estampado_al_calor').prop('checked') ) {

      $('#contenedorEstampado_al_calor').appendTo('#contenedorEstado');
      $('#contenedorEstampado_al_calor').addClass( "col-3" );
      $('#origenEstampado_al_calor').hide()
    }else {
      $('#origenEstampado_al_calor').show()
      $('#contenedorEstampado_al_calor').appendTo('#origenEstampado_al_calor');
      $('#contenedorEstampado_al_calor').removeClass( "col-3" )
    }

  })


  $("#montaje_termoformado").change(function(){



    if( $('#montaje_termoformado').prop('checked') ) {

      $('#contenedorTermoformado').appendTo('#contenedorEstado');
      $('#contenedorTermoformado').addClass( "col-2" );
      $('#origenTermoformado').hide()
    }else {
      $('#origenTermoformado').show()
      $('#contenedorTermoformado').appendTo('#origenTermoformado');
      $('#contenedorTermoformado').removeClass( "col-2" )
    }

  })




  $("#montaje_doblez_calor").change(function(){



    if( $('#montaje_doblez_calor').prop('checked') ) {

      $('#contenedorDoblez_calor').appendTo('#contenedorEstado');
      $('#contenedorDoblez_calor').addClass( "col-2" );
      $('#origenDoblez_calor').hide()
    }else {
      $('#origenDoblez_calor').show()
      $('#contenedorDoblez_calor').appendTo('#origenDoblez_calor');
      $('#contenedorDoblez_calor').removeClass( "col-2" )
    }

  })





$("#montaje_descolille").change(function(){



  if( $('#montaje_descolille').prop('checked') ) {

    $('#contenedorDescolille').appendTo('#contenedorEstado');
    $('#contenedorDescolille').appendTo('#contenedorEstado');
    $('#origenDescolille').hide()
  }else {
    $('#origenDescolille').show()
    $('#contenedorDescolille').appendTo('#origenDescolille');
  }

})

  $(".js-example-tokenizer").select2({
      tags: true,
      tokenSeparators: [',', ' ']
  })

  $('#value_otro').on("select2:select", function (e) {
    var valores = e.params.data.id;
    var contenido_otro = $('#montaje_otro').val()
    $("#montaje_otro").val(contenido_otro+", "+valores)

  })




/*

  $.ajax: {

    url: "http://localhost:3000/busquedaTintas.json",
    dataType: 'json',
    delay:250,
    processResults: function (data, params){
      console.log(data);

      function formatRepo (repo) {

      }
    }
  }

*/



$(".js-example-data-ajax-Tintas").select2({


})

$(".js-example-tags").select2({


})










$("#montaje_tiro").attr('checked',true);
$("#tiro_mont").hide();
  if( $('#montaje_tiro').prop('checked') ) {
    $('#div_tintas_tiro').show()
    $(".js-example-tags").select2({


    })
  }else {
    $('#div_tintas_tiro').hide()
  }


  if( $('#montaje_retiro').prop('checked') ) {

    $('#div_tintas_retiro').show()
    $(".js-example-tags").select2({


    })
  }else {
    $('#div_tintas_retiro').hide()

  }


$("#montaje_tiro").change(function(){


  if( $('#montaje_tiro').prop('checked') ) {

    $('#div_tintas_tiro').show()
    $(".js-example-tags").select2({


    })
  }else {

    $('#div_tintas_tiro').hide()
  }


})


$("#montaje_retiro").change(function(){


  if( $('#montaje_retiro').prop('checked') ) {

    $('#div_tintas_retiro').show()
    $(".js-example-tags").select2({


    })
  }else {
    $('#div_tintas_retiro').hide()

  }


})

$('form').on('click', '.remove_formula', function(event) {
  $(this).prev('input[type=hidden]').val('1');
  $(this).closest('tr').hide();

  return event.preventDefault();
});

$('form').on('click', '.add_formula', function(event) {
  var regexp, time;
  time = new Date().getTime();
  regexp = new RegExp($(this).data('id'), 'g');
  $('.fields_formula').append($(this).data('fields').replace(regexp, time));

  return event.preventDefault();
});


  $('form').on('click', '.remove_tintas_retiro', function(event) {
    $(".js-example-tags").select2({
        tags : true ,
        tokenSeparators : [',']
    });
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();

    return event.preventDefault();
  });

  $('form').on('click', '.add_tintas_retiro', function(event) {
    $(".js-example-tags").select2({
        tags : true ,
        tokenSeparators : [',']
    });
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_tintas_retiro').append($(this).data('fields').replace(regexp, time));

    return event.preventDefault();
  });




  $('form').on('click', '.remove_tintas_tiro', function(event) {
    $(".js-example-tags").select2({
        tags : true ,
        tokenSeparators : [',']
    });
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').remove();

    return event.preventDefault();
  });

  $('form').on('click', '.add_tintas_tiro', function(event) {
    $(".js-example-tags").select2({
        tags : true ,
        tokenSeparators : [',']
    });
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_tintas_tiro').append($(this).data('fields').replace(regexp, time));

    return event.preventDefault();
  });

//ordenes_produccion

$("#buscandoControlador").on("select2:select", function (e) {
  var fop_id = e.params.data.id;
  $.ajax({
    url:'/select_buscar_montaje/'+fop_id+'',
    method:'get',
    success: function (data){
      console.log();

    }
  })

})


var busVal = $("#buscandoControlador").select2("val")

if (busVal == null ) {



}else {
  if (busVal.length != 0 ) {


        $.ajax({
          url:'/select_buscar_montaje/'+busVal+'',
          method:'get',
          success: function (data){
            console.log();

          }
        })
  }
}



$('#busqueda_fop').on("select2:select", function (e) {
  var fop_id = e.params.data.id;
  $.ajax({
    url:'/buscar_fop/'+fop_id+'.json',
    method:'get',
    success: function(data){

      var data_length = 1;

      for (var i = 0; i < data_length; i++) {




        var vendedor_id = data["0"]["montaje"]["user_id"];
        var maquina = data["0"] ["maquina"]["nombre"]
        var montaje_id = data["0"] ["montaje"]["id"]
        var linea_producto = data ["0"]["linea_producto"]["nombre"]
        var linea_de_color = data ["0"]["linea_de_color"]["nombre"]
        var material = data ["0"]["material"]
        var cliente_id = data ["0"]["montaje"]["cliente_id"]


        $('#op_maquina').val(maquina)
        $('#op_linea_producto').val(linea_producto)
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

        $.ajax({
          url:'/users/'+vendedor_id+'.json',
          method:'get',
          success: function (data){
            var vendedor_lentgh = 1;
            for (var i = 0; i < vendedor_lentgh; i++) {

              var vendedor = data ["nombre"]
              $('#op_vendedor').val(vendedor)

            }
          }
        })

        $.ajax({
          url:'/busquedaTintasMontaje/'+montaje_id+'.json',
          method:'get',
          success: function (data){
            var tintas_lentgh = 1;
            for (var i = 0; i < tintas_lentgh; i++) {

              var Tintas_Tiro = data ["tintas_fop_tiro"].length

              for (var j = 0; j < Tintas_Tiro; j++) {

                var Tintas = data ["tintas_fop_tiro"][j]["descripcion"]
                var T_id = data ["tintas_fop_tiro"][j]["id"]



                var contenedor = "<div class='my_card_produccion col-6'><div class='col-12'></div><div class='card col-12'><ul class='list-group list-group-flush'><li class='list-group-item container my_card_produccion'><div class=''><div><strong>Tinta:</strong></div></div><div class='col-3'><strong>Malla:</strong></div></li><li class='list-group-item container my_card_produccion'><div class='col-9'><p>"+Tintas+"</p></div><div class='col-3'><p class='m"+T_id+"'></p></div></li></ul></div></div>"

                $("#AgregarTintaTiro").append(contenedor)
                console.log(Tintas);



                $.ajax({
                  url:'/mallas/'+malla_id+'.json',
                  method:'get',
                  success: function (data){
                    var vendedor_lentgh = 1;
                    for (var i = 0; i < vendedor_lentgh; i++) {





                    }
                  }
                })

              }


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
    $(this).closest('tr').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_piezas', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_piezas').append($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });


  $('form').on('click', '.remove_compromisos', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });

  $('form').on('click', '.add_compromisos', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_compromisos').append($(this).data('fields').replace(regexp, time));
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


  $('form').on('click', '.remove_desarrollo_tintas', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('tr').hide();
    return event.preventDefault();
  });



  $(".js-example-tintas").select2({
    tags: true,
    tokenSeparators: [',', ' ']
  })

  $('form').on('click', '.add_desarrollo_tintas', function(event) {

    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $('.fields_desarrollo_tintas').append($(this).data('fields').replace(regexp, time));
    $(".js-example-tags").select2({


    })

    $(".js-example-tintas").select2({
      tags: true,
      tokenSeparators: [',', ' ']
    })
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
