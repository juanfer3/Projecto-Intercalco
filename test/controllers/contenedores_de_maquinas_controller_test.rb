require 'test_helper'

class ContenedoresDeMaquinasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contenedor_de_maquinas = contenedores_de_maquinas(:one)
  end

  test "should get index" do
    get contenedores_de_maquinas_url
    assert_response :success
  end

  test "should get new" do
    get new_contenedor_de_maquinas_url
    assert_response :success
  end

  test "should create contenedor_de_maquinas" do
    assert_difference('ContenedorDeMaquinas.count') do
      post contenedores_de_maquinas_url, params: { contenedor_de_maquinas: { maquina_id: @contenedor_de_maquinas.maquina_id, orden_produccion_id: @contenedor_de_maquinas.orden_produccion_id } }
    end

    assert_redirected_to contenedor_de_maquinas_url(ContenedorDeMaquinas.last)
  end

  test "should show contenedor_de_maquinas" do
    get contenedor_de_maquinas_url(@contenedor_de_maquinas)
    assert_response :success
  end

  test "should get edit" do
    get edit_contenedor_de_maquinas_url(@contenedor_de_maquinas)
    assert_response :success
  end

  test "should update contenedor_de_maquinas" do
    patch contenedor_de_maquinas_url(@contenedor_de_maquinas), params: { contenedor_de_maquinas: { maquina_id: @contenedor_de_maquinas.maquina_id, orden_produccion_id: @contenedor_de_maquinas.orden_produccion_id } }
    assert_redirected_to contenedor_de_maquinas_url(@contenedor_de_maquinas)
  end

  test "should destroy contenedor_de_maquinas" do
    assert_difference('ContenedorDeMaquinas.count', -1) do
      delete contenedor_de_maquinas_url(@contenedor_de_maquinas)
    end

    assert_redirected_to contenedores_de_maquinas_url
  end
end
