require 'test_helper'

class PiezasADecorarControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pieza_a_decorar = piezas_a_decorar(:one)
  end

  test "should get index" do
    get piezas_a_decorar_url
    assert_response :success
  end

  test "should get new" do
    get new_pieza_a_decorar_url
    assert_response :success
  end

  test "should create pieza_a_decorar" do
    assert_difference('PiezaADecorar.count') do
      post piezas_a_decorar_url, params: { pieza_a_decorar: { descripccion: @pieza_a_decorar.descripccion, estado: @pieza_a_decorar.estado, nombre: @pieza_a_decorar.nombre } }
    end

    assert_redirected_to pieza_a_decorar_url(PiezaADecorar.last)
  end

  test "should show pieza_a_decorar" do
    get pieza_a_decorar_url(@pieza_a_decorar)
    assert_response :success
  end

  test "should get edit" do
    get edit_pieza_a_decorar_url(@pieza_a_decorar)
    assert_response :success
  end

  test "should update pieza_a_decorar" do
    patch pieza_a_decorar_url(@pieza_a_decorar), params: { pieza_a_decorar: { descripccion: @pieza_a_decorar.descripccion, estado: @pieza_a_decorar.estado, nombre: @pieza_a_decorar.nombre } }
    assert_redirected_to pieza_a_decorar_url(@pieza_a_decorar)
  end

  test "should destroy pieza_a_decorar" do
    assert_difference('PiezaADecorar.count', -1) do
      delete pieza_a_decorar_url(@pieza_a_decorar)
    end

    assert_redirected_to piezas_a_decorar_url
  end
end
