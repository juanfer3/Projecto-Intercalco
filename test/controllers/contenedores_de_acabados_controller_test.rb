require 'test_helper'

class ContenedoresDeAcabadosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contenedor_de_acabados = contenedores_de_acabados(:one)
  end

  test "should get index" do
    get contenedores_de_acabados_url
    assert_response :success
  end

  test "should get new" do
    get new_contenedor_de_acabados_url
    assert_response :success
  end

  test "should create contenedor_de_acabados" do
    assert_difference('ContenedorDeAcabados.count') do
      post contenedores_de_acabados_url, params: { contenedor_de_acabados: { acabado_id: @contenedor_de_acabados.acabado_id, montaje_id: @contenedor_de_acabados.montaje_id } }
    end

    assert_redirected_to contenedor_de_acabados_url(ContenedorDeAcabados.last)
  end

  test "should show contenedor_de_acabados" do
    get contenedor_de_acabados_url(@contenedor_de_acabados)
    assert_response :success
  end

  test "should get edit" do
    get edit_contenedor_de_acabados_url(@contenedor_de_acabados)
    assert_response :success
  end

  test "should update contenedor_de_acabados" do
    patch contenedor_de_acabados_url(@contenedor_de_acabados), params: { contenedor_de_acabados: { acabado_id: @contenedor_de_acabados.acabado_id, montaje_id: @contenedor_de_acabados.montaje_id } }
    assert_redirected_to contenedor_de_acabados_url(@contenedor_de_acabados)
  end

  test "should destroy contenedor_de_acabados" do
    assert_difference('ContenedorDeAcabados.count', -1) do
      delete contenedor_de_acabados_url(@contenedor_de_acabados)
    end

    assert_redirected_to contenedores_de_acabados_url
  end
end
