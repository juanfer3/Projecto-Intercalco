require 'test_helper'

class ContenedoresDeOrdenesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contenedor_de_ordenes = contenedores_de_ordenes(:one)
  end

  test "should get index" do
    get contenedores_de_ordenes_url
    assert_response :success
  end

  test "should get new" do
    get new_contenedor_de_ordenes_url
    assert_response :success
  end

  test "should create contenedor_de_ordenes" do
    assert_difference('ContenedorDeOrdenes.count') do
      post contenedores_de_ordenes_url, params: { contenedor_de_ordenes: { factura_id: @contenedor_de_ordenes.factura_id, orden_produccion_id: @contenedor_de_ordenes.orden_produccion_id } }
    end

    assert_redirected_to contenedor_de_ordenes_url(ContenedorDeOrdenes.last)
  end

  test "should show contenedor_de_ordenes" do
    get contenedor_de_ordenes_url(@contenedor_de_ordenes)
    assert_response :success
  end

  test "should get edit" do
    get edit_contenedor_de_ordenes_url(@contenedor_de_ordenes)
    assert_response :success
  end

  test "should update contenedor_de_ordenes" do
    patch contenedor_de_ordenes_url(@contenedor_de_ordenes), params: { contenedor_de_ordenes: { factura_id: @contenedor_de_ordenes.factura_id, orden_produccion_id: @contenedor_de_ordenes.orden_produccion_id } }
    assert_redirected_to contenedor_de_ordenes_url(@contenedor_de_ordenes)
  end

  test "should destroy contenedor_de_ordenes" do
    assert_difference('ContenedorDeOrdenes.count', -1) do
      delete contenedor_de_ordenes_url(@contenedor_de_ordenes)
    end

    assert_redirected_to contenedores_de_ordenes_url
  end
end
