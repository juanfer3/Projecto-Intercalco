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
      post tiempos_de_entregas_url, params: { tiempos_de_entrega: { cantidad: @tiempos_de_entrega.cantidad, estado: @tiempos_de_entrega.estado, fecha_compromiso: @tiempos_de_entrega.fecha_compromiso, pedido_id: @tiempos_de_entrega.pedido_id, precio: @tiempos_de_entrega.precio } }
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
    patch tiempos_de_entrega_url(@tiempos_de_entrega), params: { tiempos_de_entrega: { cantidad: @tiempos_de_entrega.cantidad, estado: @tiempos_de_entrega.estado, fecha_compromiso: @tiempos_de_entrega.fecha_compromiso, pedido_id: @tiempos_de_entrega.pedido_id, precio: @tiempos_de_entrega.precio } }
    assert_redirected_to tiempos_de_entrega_url(@tiempos_de_entrega)
  end

  test "should destroy tiempos_de_entrega" do
    assert_difference('TiemposDeEntrega.count', -1) do
      delete tiempos_de_entrega_url(@tiempos_de_entrega)
    end

    assert_redirected_to tiempos_de_entregas_url
  end
end
