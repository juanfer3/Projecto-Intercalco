require 'test_helper'

class ProduccionesOrdenesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @produccion_orden = producciones_ordenes(:one)
  end

  test "should get index" do
    get producciones_ordenes_url
    assert_response :success
  end

  test "should get new" do
    get new_produccion_orden_url
    assert_response :success
  end

  test "should create produccion_orden" do
    assert_difference('ProduccionOrden.count') do
      post producciones_ordenes_url, params: { produccion_orden: { acabado: @produccion_orden.acabado, cantidad_hoja: @produccion_orden.cantidad_hoja, cantidad_programada: @produccion_orden.cantidad_programada, cavidad: @produccion_orden.cavidad, cliente_id: @produccion_orden.cliente_id, color: @produccion_orden.color, corte_material: @produccion_orden.corte_material, estado: @produccion_orden.estado, estado_de_orde: @produccion_orden.estado_de_orde, fecha: @produccion_orden.fecha, fecha_compromiso: @produccion_orden.fecha_compromiso, habilitar_acabado: @produccion_orden.habilitar_acabado, habilitar_impresion: @produccion_orden.habilitar_impresion, impresion: @produccion_orden.impresion, maquina_id: @produccion_orden.maquina_id, mes: @produccion_orden.mes, montaje_id: @produccion_orden.montaje_id, numero_de_orden: @produccion_orden.numero_de_orden, observacion: @produccion_orden.observacion, pantalla: @produccion_orden.pantalla, pieza_a_decorar_id: @produccion_orden.pieza_a_decorar_id, precio_unitario: @produccion_orden.precio_unitario, retiro: @produccion_orden.retiro, tamanos_total: @produccion_orden.tamanos_total, tipo_de_linea: @produccion_orden.tipo_de_linea, tipo_de_produccion: @produccion_orden.tipo_de_produccion, tiro: @produccion_orden.tiro, troquel: @produccion_orden.troquel, user_id: @produccion_orden.user_id, valor_total: @produccion_orden.valor_total } }
    end

    assert_redirected_to produccion_orden_url(ProduccionOrden.last)
  end

  test "should show produccion_orden" do
    get produccion_orden_url(@produccion_orden)
    assert_response :success
  end

  test "should get edit" do
    get edit_produccion_orden_url(@produccion_orden)
    assert_response :success
  end

  test "should update produccion_orden" do
    patch produccion_orden_url(@produccion_orden), params: { produccion_orden: { acabado: @produccion_orden.acabado, cantidad_hoja: @produccion_orden.cantidad_hoja, cantidad_programada: @produccion_orden.cantidad_programada, cavidad: @produccion_orden.cavidad, cliente_id: @produccion_orden.cliente_id, color: @produccion_orden.color, corte_material: @produccion_orden.corte_material, estado: @produccion_orden.estado, estado_de_orde: @produccion_orden.estado_de_orde, fecha: @produccion_orden.fecha, fecha_compromiso: @produccion_orden.fecha_compromiso, habilitar_acabado: @produccion_orden.habilitar_acabado, habilitar_impresion: @produccion_orden.habilitar_impresion, impresion: @produccion_orden.impresion, maquina_id: @produccion_orden.maquina_id, mes: @produccion_orden.mes, montaje_id: @produccion_orden.montaje_id, numero_de_orden: @produccion_orden.numero_de_orden, observacion: @produccion_orden.observacion, pantalla: @produccion_orden.pantalla, pieza_a_decorar_id: @produccion_orden.pieza_a_decorar_id, precio_unitario: @produccion_orden.precio_unitario, retiro: @produccion_orden.retiro, tamanos_total: @produccion_orden.tamanos_total, tipo_de_linea: @produccion_orden.tipo_de_linea, tipo_de_produccion: @produccion_orden.tipo_de_produccion, tiro: @produccion_orden.tiro, troquel: @produccion_orden.troquel, user_id: @produccion_orden.user_id, valor_total: @produccion_orden.valor_total } }
    assert_redirected_to produccion_orden_url(@produccion_orden)
  end

  test "should destroy produccion_orden" do
    assert_difference('ProduccionOrden.count', -1) do
      delete produccion_orden_url(@produccion_orden)
    end

    assert_redirected_to producciones_ordenes_url
  end
end
