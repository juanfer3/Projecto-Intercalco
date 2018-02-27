require 'test_helper'

class LugaresDespachosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lugar_despacho = lugares_despachos(:one)
  end

  test "should get index" do
    get lugares_despachos_url
    assert_response :success
  end

  test "should get new" do
    get new_lugar_despacho_url
    assert_response :success
  end

  test "should create lugar_despacho" do
    assert_difference('LugarDespacho.count') do
      post lugares_despachos_url, params: { lugar_despacho: { cliente_id: @lugar_despacho.cliente_id, direccion: @lugar_despacho.direccion, nombre: @lugar_despacho.nombre, telefono: @lugar_despacho.telefono } }
    end

    assert_redirected_to lugar_despacho_url(LugarDespacho.last)
  end

  test "should show lugar_despacho" do
    get lugar_despacho_url(@lugar_despacho)
    assert_response :success
  end

  test "should get edit" do
    get edit_lugar_despacho_url(@lugar_despacho)
    assert_response :success
  end

  test "should update lugar_despacho" do
    patch lugar_despacho_url(@lugar_despacho), params: { lugar_despacho: { cliente_id: @lugar_despacho.cliente_id, direccion: @lugar_despacho.direccion, nombre: @lugar_despacho.nombre, telefono: @lugar_despacho.telefono } }
    assert_redirected_to lugar_despacho_url(@lugar_despacho)
  end

  test "should destroy lugar_despacho" do
    assert_difference('LugarDespacho.count', -1) do
      delete lugar_despacho_url(@lugar_despacho)
    end

    assert_redirected_to lugares_despachos_url
  end
end
