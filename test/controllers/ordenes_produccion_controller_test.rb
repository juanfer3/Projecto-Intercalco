require 'test_helper'

class OrdenesProduccionControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orden_produccion = ordenes_produccion(:one)
  end

  test "should get index" do
    get ordenes_produccion_url
    assert_response :success
  end

  test "should get new" do
    get new_orden_produccion_url
    assert_response :success
  end

  test "should create orden_produccion" do
    assert_difference('OrdenProduccion.count') do
      post ordenes_produccion_url, params: { orden_produccion: { acabado: @orden_produccion.acabado, cantidad_hoja: @orden_produccion.cantidad_hoja, cantidad_programada: @orden_produccion.cantidad_programada, cavidad: @orden_produccion.cavidad, color: @orden_produccion.color, corte_material: @orden_produccion.corte_material, estado: @orden_produccion.estado, estado_de_orden: @orden_produccion.estado_de_orden, fecha: @orden_produccion.fecha, fecha_compromiso: @orden_produccion.fecha_compromiso, formato_op_id: @orden_produccion.formato_op_id, habilitar_acabado: @orden_produccion.habilitar_acabado, habilitar_impresion: @orden_produccion.habilitar_impresion, impresion: @orden_produccion.impresion, material: @orden_produccion.material, numero_de_orden: @orden_produccion.numero_de_orden, observacion: @orden_produccion.observacion, pantalla: @orden_produccion.pantalla, porcentaje_macula: @orden_produccion.porcentaje_macula, precio_unitario: @orden_produccion.precio_unitario, retiro: @orden_produccion.retiro, tamanos_total: @orden_produccion.tamanos_total, temperatura: @orden_produccion.temperatura, tipo_de_produccion: @orden_produccion.tipo_de_produccion, tiro: @orden_produccion.tiro, troquel: @orden_produccion.troquel, valor_total: @orden_produccion.valor_total } }
    end

    assert_redirected_to orden_produccion_url(OrdenProduccion.last)
  end

  test "should show orden_produccion" do
    get orden_produccion_url(@orden_produccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_orden_produccion_url(@orden_produccion)
    assert_response :success
  end

  test "should update orden_produccion" do
    patch orden_produccion_url(@orden_produccion), params: { orden_produccion: { acabado: @orden_produccion.acabado, cantidad_hoja: @orden_produccion.cantidad_hoja, cantidad_programada: @orden_produccion.cantidad_programada, cavidad: @orden_produccion.cavidad, color: @orden_produccion.color, corte_material: @orden_produccion.corte_material, estado: @orden_produccion.estado, estado_de_orden: @orden_produccion.estado_de_orden, fecha: @orden_produccion.fecha, fecha_compromiso: @orden_produccion.fecha_compromiso, formato_op_id: @orden_produccion.formato_op_id, habilitar_acabado: @orden_produccion.habilitar_acabado, habilitar_impresion: @orden_produccion.habilitar_impresion, impresion: @orden_produccion.impresion, material: @orden_produccion.material, numero_de_orden: @orden_produccion.numero_de_orden, observacion: @orden_produccion.observacion, pantalla: @orden_produccion.pantalla, porcentaje_macula: @orden_produccion.porcentaje_macula, precio_unitario: @orden_produccion.precio_unitario, retiro: @orden_produccion.retiro, tamanos_total: @orden_produccion.tamanos_total, temperatura: @orden_produccion.temperatura, tipo_de_produccion: @orden_produccion.tipo_de_produccion, tiro: @orden_produccion.tiro, troquel: @orden_produccion.troquel, valor_total: @orden_produccion.valor_total } }
    assert_redirected_to orden_produccion_url(@orden_produccion)
  end

  test "should destroy orden_produccion" do
    assert_difference('OrdenProduccion.count', -1) do
      delete orden_produccion_url(@orden_produccion)
    end

    assert_redirected_to ordenes_produccion_url
  end
end
