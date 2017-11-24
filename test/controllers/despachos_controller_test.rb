require 'test_helper'

class DespachosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @despacho = despachos(:one)
  end

  test "should get index" do
    get despachos_url
    assert_response :success
  end

  test "should get new" do
    get new_despacho_url
    assert_response :success
  end

  test "should create despacho" do
    assert_difference('Despacho.count') do
      post despachos_url, params: { despacho: { celular: @despacho.celular, correo: @despacho.correo, direccion: @despacho.direccion, estado: @despacho.estado, facturar: @despacho.facturar, lugar_de_despacho: @despacho.lugar_de_despacho, nit: @despacho.nit, nombre: @despacho.nombre, observacion: @despacho.observacion, pedido_id: @despacho.pedido_id, recibe: @despacho.recibe, telefono: @despacho.telefono } }
    end

    assert_redirected_to despacho_url(Despacho.last)
  end

  test "should show despacho" do
    get despacho_url(@despacho)
    assert_response :success
  end

  test "should get edit" do
    get edit_despacho_url(@despacho)
    assert_response :success
  end

  test "should update despacho" do
    patch despacho_url(@despacho), params: { despacho: { celular: @despacho.celular, correo: @despacho.correo, direccion: @despacho.direccion, estado: @despacho.estado, facturar: @despacho.facturar, lugar_de_despacho: @despacho.lugar_de_despacho, nit: @despacho.nit, nombre: @despacho.nombre, observacion: @despacho.observacion, pedido_id: @despacho.pedido_id, recibe: @despacho.recibe, telefono: @despacho.telefono } }
    assert_redirected_to despacho_url(@despacho)
  end

  test "should destroy despacho" do
    assert_difference('Despacho.count', -1) do
      delete despacho_url(@despacho)
    end

    assert_redirected_to despachos_url
  end
end
