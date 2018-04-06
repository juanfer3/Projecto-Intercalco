require 'test_helper'

class VariablesEstandarControllerTest < ActionDispatch::IntegrationTest
  setup do
    @variable_estandar = variables_estandar(:one)
  end

  test "should get index" do
    get variables_estandar_url
    assert_response :success
  end

  test "should get new" do
    get new_variable_estandar_url
    assert_response :success
  end

  test "should create variable_estandar" do
    assert_difference('VariableEstandar.count') do
      post variables_estandar_url, params: { variable_estandar: { tiempo_de_montaje: @variable_estandar.tiempo_de_montaje } }
    end

    assert_redirected_to variable_estandar_url(VariableEstandar.last)
  end

  test "should show variable_estandar" do
    get variable_estandar_url(@variable_estandar)
    assert_response :success
  end

  test "should get edit" do
    get edit_variable_estandar_url(@variable_estandar)
    assert_response :success
  end

  test "should update variable_estandar" do
    patch variable_estandar_url(@variable_estandar), params: { variable_estandar: { tiempo_de_montaje: @variable_estandar.tiempo_de_montaje } }
    assert_redirected_to variable_estandar_url(@variable_estandar)
  end

  test "should destroy variable_estandar" do
    assert_difference('VariableEstandar.count', -1) do
      delete variable_estandar_url(@variable_estandar)
    end

    assert_redirected_to variables_estandar_url
  end
end
