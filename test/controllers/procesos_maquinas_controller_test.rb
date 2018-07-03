require 'test_helper'

class ProcesosMaquinasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @proceso_maquinas = procesos_maquinas(:one)
  end

  test "should get index" do
    get procesos_maquinas_url
    assert_response :success
  end

  test "should get new" do
    get new_proceso_maquinas_url
    assert_response :success
  end

  test "should create proceso_maquinas" do
    assert_difference('ProcesoMaquinas.count') do
      post procesos_maquinas_url, params: { proceso_maquinas: { cerrado: @proceso_maquinas.cerrado, contenedor_de_maquinas_id: @proceso_maquinas.contenedor_de_maquinas_id, orden_produccion_id: @proceso_maquinas.orden_produccion_id } }
    end

    assert_redirected_to proceso_maquinas_url(ProcesoMaquinas.last)
  end

  test "should show proceso_maquinas" do
    get proceso_maquinas_url(@proceso_maquinas)
    assert_response :success
  end

  test "should get edit" do
    get edit_proceso_maquinas_url(@proceso_maquinas)
    assert_response :success
  end

  test "should update proceso_maquinas" do
    patch proceso_maquinas_url(@proceso_maquinas), params: { proceso_maquinas: { cerrado: @proceso_maquinas.cerrado, contenedor_de_maquinas_id: @proceso_maquinas.contenedor_de_maquinas_id, orden_produccion_id: @proceso_maquinas.orden_produccion_id } }
    assert_redirected_to proceso_maquinas_url(@proceso_maquinas)
  end

  test "should destroy proceso_maquinas" do
    assert_difference('ProcesoMaquinas.count', -1) do
      delete proceso_maquinas_url(@proceso_maquinas)
    end

    assert_redirected_to procesos_maquinas_url
  end
end
