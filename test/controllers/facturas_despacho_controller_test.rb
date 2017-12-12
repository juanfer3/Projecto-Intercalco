require 'test_helper'

class FacturasDespachoControllerTest < ActionDispatch::IntegrationTest
  setup do
    @factura_despacho = facturas_despacho(:one)
  end

  test "should get index" do
    get facturas_despacho_url
    assert_response :success
  end

  test "should get new" do
    get new_factura_despacho_url
    assert_response :success
  end

  test "should create factura_despacho" do
    assert_difference('FacturaDespacho.count') do
      post facturas_despacho_url, params: { factura_despacho: { cancelada: @factura_despacho.cancelada, cantidad_faltante: @factura_despacho.cantidad_faltante, descuento: @factura_despacho.descuento, estado: @factura_despacho.estado, iva: @factura_despacho.iva, numero_de_factura: @factura_despacho.numero_de_factura, tiempos_de_entrega_id: @factura_despacho.tiempos_de_entrega_id, total_enviado: @factura_despacho.total_enviado, total_facturado: @factura_despacho.total_facturado } }
    end

    assert_redirected_to factura_despacho_url(FacturaDespacho.last)
  end

  test "should show factura_despacho" do
    get factura_despacho_url(@factura_despacho)
    assert_response :success
  end

  test "should get edit" do
    get edit_factura_despacho_url(@factura_despacho)
    assert_response :success
  end

  test "should update factura_despacho" do
    patch factura_despacho_url(@factura_despacho), params: { factura_despacho: { cancelada: @factura_despacho.cancelada, cantidad_faltante: @factura_despacho.cantidad_faltante, descuento: @factura_despacho.descuento, estado: @factura_despacho.estado, iva: @factura_despacho.iva, numero_de_factura: @factura_despacho.numero_de_factura, tiempos_de_entrega_id: @factura_despacho.tiempos_de_entrega_id, total_enviado: @factura_despacho.total_enviado, total_facturado: @factura_despacho.total_facturado } }
    assert_redirected_to factura_despacho_url(@factura_despacho)
  end

  test "should destroy factura_despacho" do
    assert_difference('FacturaDespacho.count', -1) do
      delete factura_despacho_url(@factura_despacho)
    end

    assert_redirected_to facturas_despacho_url
  end
end
