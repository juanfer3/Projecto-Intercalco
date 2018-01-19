require 'test_helper'

class TintasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tinta = tintas(:one)
  end

  test "should get index" do
    get tintas_url
    assert_response :success
  end

  test "should get new" do
    get new_tinta_url
    assert_response :success
  end

  test "should create tinta" do
    assert_difference('Tinta.count') do
      post tintas_url, params: { tinta: { codigo: @tinta.codigo, descripcion: @tinta.descripcion, estado: @tinta.estado, formulado: @tinta.formulado, linea_de_color_id: @tinta.linea_de_color_id } }
    end

    assert_redirected_to tinta_url(Tinta.last)
  end

  test "should show tinta" do
    get tinta_url(@tinta)
    assert_response :success
  end

  test "should get edit" do
    get edit_tinta_url(@tinta)
    assert_response :success
  end

  test "should update tinta" do
    patch tinta_url(@tinta), params: { tinta: { codigo: @tinta.codigo, descripcion: @tinta.descripcion, estado: @tinta.estado, formulado: @tinta.formulado, linea_de_color_id: @tinta.linea_de_color_id } }
    assert_redirected_to tinta_url(@tinta)
  end

  test "should destroy tinta" do
    assert_difference('Tinta.count', -1) do
      delete tinta_url(@tinta)
    end

    assert_redirected_to tintas_url
  end
end
