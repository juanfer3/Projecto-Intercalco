require 'test_helper'

class FacturasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @factura = facturas(:one)
  end

  test "should get index" do
    get facturas_url
    assert_response :success
  end

  test "should get new" do
    get new_factura_url
    assert_response :success
  end

  test "should create factura" do
    assert_difference('Factura.count') do
      post facturas_url, params: { factura: { cancelada: @factura.cancelada, descuento: @factura.descuento, iva: @factura.iva, numero_de_factura: @factura.numero_de_factura, orden_produccion_id: @factura.orden_produccion_id, total_facturado: @factura.total_facturado } }
    end

    assert_redirected_to factura_url(Factura.last)
  end

  test "should show factura" do
    get factura_url(@factura)
    assert_response :success
  end

  test "should get edit" do
    get edit_factura_url(@factura)
    assert_response :success
  end

  test "should update factura" do
    patch factura_url(@factura), params: { factura: { cancelada: @factura.cancelada, descuento: @factura.descuento, iva: @factura.iva, numero_de_factura: @factura.numero_de_factura, orden_produccion_id: @factura.orden_produccion_id, total_facturado: @factura.total_facturado } }
    assert_redirected_to factura_url(@factura)
  end

  test "should destroy factura" do
    assert_difference('Factura.count', -1) do
      delete factura_url(@factura)
    end

    assert_redirected_to facturas_url
  end
end
