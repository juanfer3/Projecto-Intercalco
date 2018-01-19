require 'test_helper'

class TintasFormuladasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tinta_formulada = tintas_formuladas(:one)
  end

  test "should get index" do
    get tintas_formuladas_url
    assert_response :success
  end

  test "should get new" do
    get new_tinta_formulada_url
    assert_response :success
  end

  test "should create tinta_formulada" do
    assert_difference('TintaFormulada.count') do
      post tintas_formuladas_url, params: { tinta_formulada: { cantidad_total: @tinta_formulada.cantidad_total, codigo: @tinta_formulada.codigo, descripcion: @tinta_formulada.descripcion, estado: @tinta_formulada.estado, linea_de_color_id: @tinta_formulada.linea_de_color_id, malla_id: @tinta_formulada.malla_id, pantone: @tinta_formulada.pantone } }
    end

    assert_redirected_to tinta_formulada_url(TintaFormulada.last)
  end

  test "should show tinta_formulada" do
    get tinta_formulada_url(@tinta_formulada)
    assert_response :success
  end

  test "should get edit" do
    get edit_tinta_formulada_url(@tinta_formulada)
    assert_response :success
  end

  test "should update tinta_formulada" do
    patch tinta_formulada_url(@tinta_formulada), params: { tinta_formulada: { cantidad_total: @tinta_formulada.cantidad_total, codigo: @tinta_formulada.codigo, descripcion: @tinta_formulada.descripcion, estado: @tinta_formulada.estado, linea_de_color_id: @tinta_formulada.linea_de_color_id, malla_id: @tinta_formulada.malla_id, pantone: @tinta_formulada.pantone } }
    assert_redirected_to tinta_formulada_url(@tinta_formulada)
  end

  test "should destroy tinta_formulada" do
    assert_difference('TintaFormulada.count', -1) do
      delete tinta_formulada_url(@tinta_formulada)
    end

    assert_redirected_to tintas_formuladas_url
  end
end
