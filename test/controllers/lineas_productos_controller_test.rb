require 'test_helper'

class LineasProductosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @linea_producto = lineas_productos(:one)
  end

  test "should get index" do
    get lineas_productos_url
    assert_response :success
  end

  test "should get new" do
    get new_linea_producto_url
    assert_response :success
  end

  test "should create linea_producto" do
    assert_difference('LineaProducto.count') do
      post lineas_productos_url, params: { linea_producto: { descripcion: @linea_producto.descripcion, estado: @linea_producto.estado, nombre: @linea_producto.nombre } }
    end

    assert_redirected_to linea_producto_url(LineaProducto.last)
  end

  test "should show linea_producto" do
    get linea_producto_url(@linea_producto)
    assert_response :success
  end

  test "should get edit" do
    get edit_linea_producto_url(@linea_producto)
    assert_response :success
  end

  test "should update linea_producto" do
    patch linea_producto_url(@linea_producto), params: { linea_producto: { descripcion: @linea_producto.descripcion, estado: @linea_producto.estado, nombre: @linea_producto.nombre } }
    assert_redirected_to linea_producto_url(@linea_producto)
  end

  test "should destroy linea_producto" do
    assert_difference('LineaProducto.count', -1) do
      delete linea_producto_url(@linea_producto)
    end

    assert_redirected_to lineas_productos_url
  end
end
