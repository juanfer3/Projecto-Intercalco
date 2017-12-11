require 'test_helper'

class RemisionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @remision = remisiones(:one)
  end

  test "should get index" do
    get remisiones_url
    assert_response :success
  end

  test "should get new" do
    get new_remision_url
    assert_response :success
  end

  test "should create remision" do
    assert_difference('Remision.count') do
      post remisiones_url, params: { remision: { cantidad_enviada: @remision.cantidad_enviada, cantidad_faltante: @remision.cantidad_faltante, entrega_cumplida: @remision.entrega_cumplida, estado: @remision.estado, factura_despacho_id: @remision.factura_despacho_id, fecha_de_despacho: @remision.fecha_de_despacho, precio_a_facturar: @remision.precio_a_facturar, tiempos_de_entrega_id: @remision.tiempos_de_entrega_id } }
    end

    assert_redirected_to remision_url(Remision.last)
  end

  test "should show remision" do
    get remision_url(@remision)
    assert_response :success
  end

  test "should get edit" do
    get edit_remision_url(@remision)
    assert_response :success
  end

  test "should update remision" do
    patch remision_url(@remision), params: { remision: { cantidad_enviada: @remision.cantidad_enviada, cantidad_faltante: @remision.cantidad_faltante, entrega_cumplida: @remision.entrega_cumplida, estado: @remision.estado, factura_despacho_id: @remision.factura_despacho_id, fecha_de_despacho: @remision.fecha_de_despacho, precio_a_facturar: @remision.precio_a_facturar, tiempos_de_entrega_id: @remision.tiempos_de_entrega_id } }
    assert_redirected_to remision_url(@remision)
  end

  test "should destroy remision" do
    assert_difference('Remision.count', -1) do
      delete remision_url(@remision)
    end

    assert_redirected_to remisiones_url
  end
end
