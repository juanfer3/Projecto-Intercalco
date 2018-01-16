require 'test_helper'

class MesesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mes = meses(:one)
  end

  test "should get index" do
    get meses_url
    assert_response :success
  end

  test "should get new" do
    get new_mes_url
    assert_response :success
  end

  test "should create mes" do
    assert_difference('Mes.count') do
      post meses_url, params: { mes: { dias: @mes.dias, estado: @mes.estado, nombre: @mes.nombre, observacion: @mes.observacion } }
    end

    assert_redirected_to mes_url(Mes.last)
  end

  test "should show mes" do
    get mes_url(@mes)
    assert_response :success
  end

  test "should get edit" do
    get edit_mes_url(@mes)
    assert_response :success
  end

  test "should update mes" do
    patch mes_url(@mes), params: { mes: { dias: @mes.dias, estado: @mes.estado, nombre: @mes.nombre, observacion: @mes.observacion } }
    assert_redirected_to mes_url(@mes)
  end

  test "should destroy mes" do
    assert_difference('Mes.count', -1) do
      delete mes_url(@mes)
    end

    assert_redirected_to meses_url
  end
end
