require 'test_helper'

class DetallesDeProduccionControllerTest < ActionDispatch::IntegrationTest
  setup do
    @detalle_de_produccion = detalles_de_produccion(:one)
  end

  test "should get index" do
    get detalles_de_produccion_url
    assert_response :success
  end

  test "should get new" do
    get new_detalle_de_produccion_url
    assert_response :success
  end

  test "should create detalle_de_produccion" do
    assert_difference('DetalleDeProduccion.count') do
      post detalles_de_produccion_url, params: { detalle_de_produccion: { cantidad: @detalle_de_produccion.cantidad, codigo: @detalle_de_produccion.codigo, descripcion: @detalle_de_produccion.descripcion, estado: @detalle_de_produccion.estado, fecha: @detalle_de_produccion.fecha, inventario: @detalle_de_produccion.inventario, orden_de_produccion_id: @detalle_de_produccion.orden_de_produccion_id } }
    end

    assert_redirected_to detalle_de_produccion_url(DetalleDeProduccion.last)
  end

  test "should show detalle_de_produccion" do
    get detalle_de_produccion_url(@detalle_de_produccion)
    assert_response :success
  end

  test "should get edit" do
    get edit_detalle_de_produccion_url(@detalle_de_produccion)
    assert_response :success
  end

  test "should update detalle_de_produccion" do
    patch detalle_de_produccion_url(@detalle_de_produccion), params: { detalle_de_produccion: { cantidad: @detalle_de_produccion.cantidad, codigo: @detalle_de_produccion.codigo, descripcion: @detalle_de_produccion.descripcion, estado: @detalle_de_produccion.estado, fecha: @detalle_de_produccion.fecha, inventario: @detalle_de_produccion.inventario, orden_de_produccion_id: @detalle_de_produccion.orden_de_produccion_id } }
    assert_redirected_to detalle_de_produccion_url(@detalle_de_produccion)
  end

  test "should destroy detalle_de_produccion" do
    assert_difference('DetalleDeProduccion.count', -1) do
      delete detalle_de_produccion_url(@detalle_de_produccion)
    end

    assert_redirected_to detalles_de_produccion_url
  end
end
