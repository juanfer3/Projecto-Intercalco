require 'test_helper'

class AcabadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @acabado = acabados(:one)
  end

  test "should get index" do
    get acabados_url
    assert_response :success
  end

  test "should get new" do
    get new_acabado_url
    assert_response :success
  end

  test "should create acabado" do
    assert_difference('Acabado.count') do
      post acabados_url, params: { acabado: { descripcion: @acabado.descripcion, nombre: @acabado.nombre } }
    end

    assert_redirected_to acabado_url(Acabado.last)
  end

  test "should show acabado" do
    get acabado_url(@acabado)
    assert_response :success
  end

  test "should get edit" do
    get edit_acabado_url(@acabado)
    assert_response :success
  end

  test "should update acabado" do
    patch acabado_url(@acabado), params: { acabado: { descripcion: @acabado.descripcion, nombre: @acabado.nombre } }
    assert_redirected_to acabado_url(@acabado)
  end

  test "should destroy acabado" do
    assert_difference('Acabado.count', -1) do
      delete acabado_url(@acabado)
    end

    assert_redirected_to acabados_url
  end
end
