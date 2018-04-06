require 'test_helper'

class ProgramacionesOpMaquinasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @programacion_op_maquina = programaciones_op_maquinas(:one)
  end

  test "should get index" do
    get programaciones_op_maquinas_url
    assert_response :success
  end

  test "should get new" do
    get new_programacion_op_maquina_url
    assert_response :success
  end

  test "should create programacion_op_maquina" do
    assert_difference('ProgramacionOpMaquina.count') do
      post programaciones_op_maquinas_url, params: { programacion_op_maquina: { cantidad_maquinas: @programacion_op_maquina.cantidad_maquinas, complemento: @programacion_op_maquina.complemento, habilitado: @programacion_op_maquina.habilitado, hora_final: @programacion_op_maquina.hora_final, hora_inicio: @programacion_op_maquina.hora_inicio, maquina_id: @programacion_op_maquina.maquina_id, orden_produccion_id: @programacion_op_maquina.orden_produccion_id, tiempo_de_desmontaje: @programacion_op_maquina.tiempo_de_desmontaje, tiempo_de_montaje: @programacion_op_maquina.tiempo_de_montaje, tiempo_por_maquina: @programacion_op_maquina.tiempo_por_maquina, total_hora: @programacion_op_maquina.total_hora } }
    end

    assert_redirected_to programacion_op_maquina_url(ProgramacionOpMaquina.last)
  end

  test "should show programacion_op_maquina" do
    get programacion_op_maquina_url(@programacion_op_maquina)
    assert_response :success
  end

  test "should get edit" do
    get edit_programacion_op_maquina_url(@programacion_op_maquina)
    assert_response :success
  end

  test "should update programacion_op_maquina" do
    patch programacion_op_maquina_url(@programacion_op_maquina), params: { programacion_op_maquina: { cantidad_maquinas: @programacion_op_maquina.cantidad_maquinas, complemento: @programacion_op_maquina.complemento, habilitado: @programacion_op_maquina.habilitado, hora_final: @programacion_op_maquina.hora_final, hora_inicio: @programacion_op_maquina.hora_inicio, maquina_id: @programacion_op_maquina.maquina_id, orden_produccion_id: @programacion_op_maquina.orden_produccion_id, tiempo_de_desmontaje: @programacion_op_maquina.tiempo_de_desmontaje, tiempo_de_montaje: @programacion_op_maquina.tiempo_de_montaje, tiempo_por_maquina: @programacion_op_maquina.tiempo_por_maquina, total_hora: @programacion_op_maquina.total_hora } }
    assert_redirected_to programacion_op_maquina_url(@programacion_op_maquina)
  end

  test "should destroy programacion_op_maquina" do
    assert_difference('ProgramacionOpMaquina.count', -1) do
      delete programacion_op_maquina_url(@programacion_op_maquina)
    end

    assert_redirected_to programaciones_op_maquinas_url
  end
end
