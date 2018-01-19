require 'test_helper'

class TintasFopRetiroControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tinta_fop_retiro = tintas_fop_retiro(:one)
  end

  test "should get index" do
    get tintas_fop_retiro_url
    assert_response :success
  end

  test "should get new" do
    get new_tinta_fop_retiro_url
    assert_response :success
  end

  test "should create tinta_fop_retiro" do
    assert_difference('TintaFopRetiro.count') do
      post tintas_fop_retiro_url, params: { tinta_fop_retiro: { descripcion: @tinta_fop_retiro.descripcion, estado: @tinta_fop_retiro.estado, malla_id: @tinta_fop_retiro.malla_id, montaje_id: @tinta_fop_retiro.montaje_id, tinta: @tinta_fop_retiro.tinta } }
    end

    assert_redirected_to tinta_fop_retiro_url(TintaFopRetiro.last)
  end

  test "should show tinta_fop_retiro" do
    get tinta_fop_retiro_url(@tinta_fop_retiro)
    assert_response :success
  end

  test "should get edit" do
    get edit_tinta_fop_retiro_url(@tinta_fop_retiro)
    assert_response :success
  end

  test "should update tinta_fop_retiro" do
    patch tinta_fop_retiro_url(@tinta_fop_retiro), params: { tinta_fop_retiro: { descripcion: @tinta_fop_retiro.descripcion, estado: @tinta_fop_retiro.estado, malla_id: @tinta_fop_retiro.malla_id, montaje_id: @tinta_fop_retiro.montaje_id, tinta: @tinta_fop_retiro.tinta } }
    assert_redirected_to tinta_fop_retiro_url(@tinta_fop_retiro)
  end

  test "should destroy tinta_fop_retiro" do
    assert_difference('TintaFopRetiro.count', -1) do
      delete tinta_fop_retiro_url(@tinta_fop_retiro)
    end

    assert_redirected_to tintas_fop_retiro_url
  end
end
