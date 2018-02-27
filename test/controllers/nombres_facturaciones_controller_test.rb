require 'test_helper'

class NombresFacturacionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nombre_facturacion = nombres_facturaciones(:one)
  end

  test "should get index" do
    get nombres_facturaciones_url
    assert_response :success
  end

  test "should get new" do
    get new_nombre_facturacion_url
    assert_response :success
  end

  test "should create nombre_facturacion" do
    assert_difference('NombreFacturacion.count') do
      post nombres_facturaciones_url, params: { nombre_facturacion: { cliente_id: @nombre_facturacion.cliente_id, direccion: @nombre_facturacion.direccion, nombre: @nombre_facturacion.nombre, telefono: @nombre_facturacion.telefono } }
    end

    assert_redirected_to nombre_facturacion_url(NombreFacturacion.last)
  end

  test "should show nombre_facturacion" do
    get nombre_facturacion_url(@nombre_facturacion)
    assert_response :success
  end

  test "should get edit" do
    get edit_nombre_facturacion_url(@nombre_facturacion)
    assert_response :success
  end

  test "should update nombre_facturacion" do
    patch nombre_facturacion_url(@nombre_facturacion), params: { nombre_facturacion: { cliente_id: @nombre_facturacion.cliente_id, direccion: @nombre_facturacion.direccion, nombre: @nombre_facturacion.nombre, telefono: @nombre_facturacion.telefono } }
    assert_redirected_to nombre_facturacion_url(@nombre_facturacion)
  end

  test "should destroy nombre_facturacion" do
    assert_difference('NombreFacturacion.count', -1) do
      delete nombre_facturacion_url(@nombre_facturacion)
    end

    assert_redirected_to nombres_facturaciones_url
  end
end
