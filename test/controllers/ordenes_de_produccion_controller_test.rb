require 'test_helper'

class OrdenesDeProduccionControllerTest < ActionDispatch::IntegrationTest
  setup do
    @orden_de_produccion = ordenes_de_produccion(:one)
  end

  test "should get index" do
    get ordenes_de_produccion_url
    assert_response :success
  end

  test "should get new" do
    get new_orden_de_produccion_url
    assert_response :success
  end

  test "should create orden_de_produccion" do
    assert_difference('OrdenDeProduccion.count') do
      post ordenes_de_produccion_url, params: { orden_de_produccion: { descripcion: @orden_de_produccion.descripcion, estado: @orden_de_produccion.estado, fecha_final: @orden_de_produccion.fecha_final, numero_de_orden: @orden_de_produccion.numero_de_orden, pedido_id: @orden_de_produccion.pedido_id, total: @orden_de_produccion.total } }
    end

    assert_redirected_to orden_de_produccion_url(OrdenDeProduccion.last)
  end

  test "should show orden_de_produccion" do
    get orden_de_produccion_url(@orden_de_produccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_orden_de_produccion_url(@orden_de_produccion)
    assert_response :success
  end

  test "should update orden_de_produccion" do
    patch orden_de_produccion_url(@orden_de_produccion), params: { orden_de_produccion: { descripcion: @orden_de_produccion.descripcion, estado: @orden_de_produccion.estado, fecha_final: @orden_de_produccion.fecha_final, numero_de_orden: @orden_de_produccion.numero_de_orden, pedido_id: @orden_de_produccion.pedido_id, total: @orden_de_produccion.total } }
    assert_redirected_to orden_de_produccion_url(@orden_de_produccion)
  end

  test "should destroy orden_de_produccion" do
    assert_difference('OrdenDeProduccion.count', -1) do
      delete orden_de_produccion_url(@orden_de_produccion)
    end

    assert_redirected_to ordenes_de_produccion_url
  end
end
