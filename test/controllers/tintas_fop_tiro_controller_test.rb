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
      post tintas_fop_tiro_url, params: { tinta_fop_tiro: { descripcion: @tinta_fop_tiro.descripcion, estado: @tinta_fop_tiro.estado, malla_id: @tinta_fop_tiro.malla_id, montaje_id: @tinta_fop_tiro.montaje_id, tinta: @tinta_fop_tiro.tinta } }
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
    patch tinta_fop_tiro_url(@tinta_fop_tiro), params: { tinta_fop_tiro: { descripcion: @tinta_fop_tiro.descripcion, estado: @tinta_fop_tiro.estado, malla_id: @tinta_fop_tiro.malla_id, montaje_id: @tinta_fop_tiro.montaje_id, tinta: @tinta_fop_tiro.tinta } }
    assert_redirected_to tinta_fop_tiro_url(@tinta_fop_tiro)
  end

  test "should destroy tinta_fop_tiro" do
    assert_difference('TintaFopTiro.count', -1) do
      delete tinta_fop_tiro_url(@tinta_fop_tiro)
    end

    assert_redirected_to tintas_fop_tiro_url
  end
end
