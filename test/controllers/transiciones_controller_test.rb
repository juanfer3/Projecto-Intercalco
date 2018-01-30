require 'test_helper'

class TransicionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transicion = transiciones(:one)
  end

  test "should get index" do
    get transiciones_url
    assert_response :success
  end

  test "should get new" do
    get new_transicion_url
    assert_response :success
  end

  test "should create transicion" do
    assert_difference('Transicion.count') do
      post transiciones_url, params: { transicion: { desarrollo_de_tinta_id: @transicion.desarrollo_de_tinta_id, tinta_formulada_id: @transicion.tinta_formulada_id } }
    end

    assert_redirected_to transicion_url(Transicion.last)
  end

  test "should show transicion" do
    get transicion_url(@transicion)
    assert_response :success
  end

  test "should get edit" do
    get edit_transicion_url(@transicion)
    assert_response :success
  end

  test "should update transicion" do
    patch transicion_url(@transicion), params: { transicion: { desarrollo_de_tinta_id: @transicion.desarrollo_de_tinta_id, tinta_formulada_id: @transicion.tinta_formulada_id } }
    assert_redirected_to transicion_url(@transicion)
  end

  test "should destroy transicion" do
    assert_difference('Transicion.count', -1) do
      delete transicion_url(@transicion)
    end

    assert_redirected_to transiciones_url
  end
end
