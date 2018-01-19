require 'test_helper'

class TintasFopTiroControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tinta_fop_tiro = tintas_fop_tiro(:one)
  end

  test "should get index" do
    get tintas_fop_tiro_url
    assert_response :success
  end

  test "should get new" do
    get new_tinta_fop_tiro_url
    assert_response :success
  end

  test "should create tinta_fop_tiro" do
    assert_difference('TintaFopTiro.count') do
      post tintas_fop_tiro_url, params: { tinta_fop_tiro: { color: @tinta_fop_tiro.color, estado: @tinta_fop_tiro.estado, formato_op_id: @tinta_fop_tiro.formato_op_id, malla_id: @tinta_fop_tiro.malla_id, tipo_de_tinta: @tinta_fop_tiro.tipo_de_tinta } }
    end

    assert_redirected_to tinta_fop_tiro_url(TintaFopTiro.last)
  end

  test "should show tinta_fop_tiro" do
    get tinta_fop_tiro_url(@tinta_fop_tiro)
    assert_response :success
  end

  test "should get edit" do
    get edit_tinta_fop_tiro_url(@tinta_fop_tiro)
    assert_response :success
  end

  test "should update tinta_fop_tiro" do
    patch tinta_fop_tiro_url(@tinta_fop_tiro), params: { tinta_fop_tiro: { color: @tinta_fop_tiro.color, estado: @tinta_fop_tiro.estado, formato_op_id: @tinta_fop_tiro.formato_op_id, malla_id: @tinta_fop_tiro.malla_id, tipo_de_tinta: @tinta_fop_tiro.tipo_de_tinta } }
    assert_redirected_to tinta_fop_tiro_url(@tinta_fop_tiro)
  end

  test "should destroy tinta_fop_tiro" do
    assert_difference('TintaFopTiro.count', -1) do
      delete tinta_fop_tiro_url(@tinta_fop_tiro)
    end

    assert_redirected_to tintas_fop_tiro_url
  end
end
