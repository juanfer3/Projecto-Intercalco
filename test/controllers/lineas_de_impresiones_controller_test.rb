require 'test_helper'

class LineasDeImpresionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @linea_de_impresion = lineas_de_impresiones(:one)
  end

  test "should get index" do
    get lineas_de_impresiones_url
    assert_response :success
  end

  test "should get new" do
    get new_linea_de_impresion_url
    assert_response :success
  end

  test "should create linea_de_impresion" do
    assert_difference('LineaDeImpresion.count') do
      post lineas_de_impresiones_url, params: { linea_de_impresion: { descripcion: @linea_de_impresion.descripcion, estado: @linea_de_impresion.estado, tipo_de_linea: @linea_de_impresion.tipo_de_linea } }
    end

    assert_redirected_to linea_de_impresion_url(LineaDeImpresion.last)
  end

  test "should show linea_de_impresion" do
    get linea_de_impresion_url(@linea_de_impresion)
    assert_response :success
  end

  test "should get edit" do
    get edit_linea_de_impresion_url(@linea_de_impresion)
    assert_response :success
  end

  test "should update linea_de_impresion" do
    patch linea_de_impresion_url(@linea_de_impresion), params: { linea_de_impresion: { descripcion: @linea_de_impresion.descripcion, estado: @linea_de_impresion.estado, tipo_de_linea: @linea_de_impresion.tipo_de_linea } }
    assert_redirected_to linea_de_impresion_url(@linea_de_impresion)
  end

  test "should destroy linea_de_impresion" do
    assert_difference('LineaDeImpresion.count', -1) do
      delete linea_de_impresion_url(@linea_de_impresion)
    end

    assert_redirected_to lineas_de_impresiones_url
  end
end
