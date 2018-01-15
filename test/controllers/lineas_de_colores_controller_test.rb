require 'test_helper'

class LineasDeColoresControllerTest < ActionDispatch::IntegrationTest
  setup do
    @linea_de_color = lineas_de_colores(:one)
  end

  test "should get index" do
    get lineas_de_colores_url
    assert_response :success
  end

  test "should get new" do
    get new_linea_de_color_url
    assert_response :success
  end

  test "should create linea_de_color" do
    assert_difference('LineaDeColor.count') do
      post lineas_de_colores_url, params: { linea_de_color: { descripcion: @linea_de_color.descripcion, estado: @linea_de_color.estado, nombre: @linea_de_color.nombre } }
    end

    assert_redirected_to linea_de_color_url(LineaDeColor.last)
  end

  test "should show linea_de_color" do
    get linea_de_color_url(@linea_de_color)
    assert_response :success
  end

  test "should get edit" do
    get edit_linea_de_color_url(@linea_de_color)
    assert_response :success
  end

  test "should update linea_de_color" do
    patch linea_de_color_url(@linea_de_color), params: { linea_de_color: { descripcion: @linea_de_color.descripcion, estado: @linea_de_color.estado, nombre: @linea_de_color.nombre } }
    assert_redirected_to linea_de_color_url(@linea_de_color)
  end

  test "should destroy linea_de_color" do
    assert_difference('LineaDeColor.count', -1) do
      delete linea_de_color_url(@linea_de_color)
    end

    assert_redirected_to lineas_de_colores_url
  end
end
