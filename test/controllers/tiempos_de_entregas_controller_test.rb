require 'test_helper'

class TiemposDeEntregasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tiempos_de_entrega = tiempos_de_entregas(:one)
  end

  test "should get index" do
    get tiempos_de_entregas_url
    assert_response :success
  end

  test "should get new" do
    get new_tiempos_de_entrega_url
    assert_response :success
  end

  test "should create tiempos_de_entrega" do
    assert_difference('TiemposDeEntrega.count') do
      post tiempos_de_entregas_url, params: { tiempos_de_entrega: { anexo: @tiempos_de_entrega.anexo, cantidad: @tiempos_de_entrega.cantidad, cantidad_enviada: @tiempos_de_entrega.cantidad_enviada, cantidad_faltante: @tiempos_de_entrega.cantidad_faltante, entrega_cumplida: @tiempos_de_entrega.entrega_cumplida, estado: @tiempos_de_entrega.estado, fecha_compromiso: @tiempos_de_entrega.fecha_compromiso, fecha_de_despacho: @tiempos_de_entrega.fecha_de_despacho, pedido_id: @tiempos_de_entrega.pedido_id, precio: @tiempos_de_entrega.precio, precio_a_facturar: @tiempos_de_entrega.precio_a_facturar, remision: @tiempos_de_entrega.remision } }
    end

    assert_redirected_to tiempos_de_entrega_url(TiemposDeEntrega.last)
  end

  test "should show tiempos_de_entrega" do
    get tiempos_de_entrega_url(@tiempos_de_entrega)
    assert_response :success
  end

  test "should get edit" do
    get edit_tiempos_de_entrega_url(@tiempos_de_entrega)
    assert_response :success
  end

  test "should update tiempos_de_entrega" do
    patch tiempos_de_entrega_url(@tiempos_de_entrega), params: { tiempos_de_entrega: { anexo: @tiempos_de_entrega.anexo, cantidad: @tiempos_de_entrega.cantidad, cantidad_enviada: @tiempos_de_entrega.cantidad_enviada, cantidad_faltante: @tiempos_de_entrega.cantidad_faltante, entrega_cumplida: @tiempos_de_entrega.entrega_cumplida, estado: @tiempos_de_entrega.estado, fecha_compromiso: @tiempos_de_entrega.fecha_compromiso, fecha_de_despacho: @tiempos_de_entrega.fecha_de_despacho, pedido_id: @tiempos_de_entrega.pedido_id, precio: @tiempos_de_entrega.precio, precio_a_facturar: @tiempos_de_entrega.precio_a_facturar, remision: @tiempos_de_entrega.remision } }
    assert_redirected_to tiempos_de_entrega_url(@tiempos_de_entrega)
  end

  test "should destroy tiempos_de_entrega" do
    assert_difference('TiemposDeEntrega.count', -1) do
      delete tiempos_de_entrega_url(@tiempos_de_entrega)
    end

    assert_redirected_to tiempos_de_entregas_url
  end
end
