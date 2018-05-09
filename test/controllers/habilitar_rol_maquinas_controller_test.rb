require 'test_helper'

class HabilitarRolMaquinasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @habilitar_rol_maquina = habilitar_rol_maquinas(:one)
  end

  test "should get index" do
    get habilitar_rol_maquinas_url
    assert_response :success
  end

  test "should get new" do
    get new_habilitar_rol_maquina_url
    assert_response :success
  end

  test "should create habilitar_rol_maquina" do
    assert_difference('HabilitarRolMaquina.count') do
      post habilitar_rol_maquinas_url, params: { habilitar_rol_maquina: { maquina_id: @habilitar_rol_maquina.maquina_id, rol_id: @habilitar_rol_maquina.rol_id } }
    end

    assert_redirected_to habilitar_rol_maquina_url(HabilitarRolMaquina.last)
  end

  test "should show habilitar_rol_maquina" do
    get habilitar_rol_maquina_url(@habilitar_rol_maquina)
    assert_response :success
  end

  test "should get edit" do
    get edit_habilitar_rol_maquina_url(@habilitar_rol_maquina)
    assert_response :success
  end

  test "should update habilitar_rol_maquina" do
    patch habilitar_rol_maquina_url(@habilitar_rol_maquina), params: { habilitar_rol_maquina: { maquina_id: @habilitar_rol_maquina.maquina_id, rol_id: @habilitar_rol_maquina.rol_id } }
    assert_redirected_to habilitar_rol_maquina_url(@habilitar_rol_maquina)
  end

  test "should destroy habilitar_rol_maquina" do
    assert_difference('HabilitarRolMaquina.count', -1) do
      delete habilitar_rol_maquina_url(@habilitar_rol_maquina)
    end

    assert_redirected_to habilitar_rol_maquinas_url
  end
end
