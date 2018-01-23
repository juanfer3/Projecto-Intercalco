require 'test_helper'

class CompromisosDeEntregaControllerTest < ActionDispatch::IntegrationTest
  setup do
    @compromiso_de_entrega = compromisos_de_entrega(:one)
  end

  test "should get index" do
    get compromisos_de_entrega_url
    assert_response :success
  end

  test "should get new" do
    get new_compromiso_de_entrega_url
    assert_response :success
  end

  test "should create compromiso_de_entrega" do
    assert_difference('CompromisoDeEntrega.count') do
      post compromisos_de_entrega_url, params: { compromiso_de_entrega: { cantidad: @compromiso_de_entrega.cantidad, cantidad_despacho: @compromiso_de_entrega.cantidad_despacho, diferencia: @compromiso_de_entrega.diferencia, estado: @compromiso_de_entrega.estado, fecha_de_compromiso: @compromiso_de_entrega.fecha_de_compromiso, fecha_despacho: @compromiso_de_entrega.fecha_despacho, numero_de_remision: @compromiso_de_entrega.numero_de_remision, orden_produccion_id: @compromiso_de_entrega.orden_produccion_id, precio: @compromiso_de_entrega.precio, precio_despacho: @compromiso_de_entrega.precio_despacho } }
    end

    assert_redirected_to compromiso_de_entrega_url(CompromisoDeEntrega.last)
  end

  test "should show compromiso_de_entrega" do
    get compromiso_de_entrega_url(@compromiso_de_entrega)
    assert_response :success
  end

  test "should get edit" do
    get edit_compromiso_de_entrega_url(@compromiso_de_entrega)
    assert_response :success
  end

  test "should update compromiso_de_entrega" do
    patch compromiso_de_entrega_url(@compromiso_de_entrega), params: { compromiso_de_entrega: { cantidad: @compromiso_de_entrega.cantidad, cantidad_despacho: @compromiso_de_entrega.cantidad_despacho, diferencia: @compromiso_de_entrega.diferencia, estado: @compromiso_de_entrega.estado, fecha_de_compromiso: @compromiso_de_entrega.fecha_de_compromiso, fecha_despacho: @compromiso_de_entrega.fecha_despacho, numero_de_remision: @compromiso_de_entrega.numero_de_remision, orden_produccion_id: @compromiso_de_entrega.orden_produccion_id, precio: @compromiso_de_entrega.precio, precio_despacho: @compromiso_de_entrega.precio_despacho } }
    assert_redirected_to compromiso_de_entrega_url(@compromiso_de_entrega)
  end

  test "should destroy compromiso_de_entrega" do
    assert_difference('CompromisoDeEntrega.count', -1) do
      delete compromiso_de_entrega_url(@compromiso_de_entrega)
    end

    assert_redirected_to compromisos_de_entrega_url
  end
end
