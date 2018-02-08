require 'test_helper'

class ContenedorDeRemisionesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contenedor_de_remision = contenedor_de_remisiones(:one)
  end

  test "should get index" do
    get contenedor_de_remisiones_url
    assert_response :success
  end

  test "should get new" do
    get new_contenedor_de_remision_url
    assert_response :success
  end

  test "should create contenedor_de_remision" do
    assert_difference('ContenedorDeRemision.count') do
      post contenedor_de_remisiones_url, params: { contenedor_de_remision: { compromiso_de_entrega_id: @contenedor_de_remision.compromiso_de_entrega_id, factura_id: @contenedor_de_remision.factura_id } }
    end

    assert_redirected_to contenedor_de_remision_url(ContenedorDeRemision.last)
  end

  test "should show contenedor_de_remision" do
    get contenedor_de_remision_url(@contenedor_de_remision)
    assert_response :success
  end

  test "should get edit" do
    get edit_contenedor_de_remision_url(@contenedor_de_remision)
    assert_response :success
  end

  test "should update contenedor_de_remision" do
    patch contenedor_de_remision_url(@contenedor_de_remision), params: { contenedor_de_remision: { compromiso_de_entrega_id: @contenedor_de_remision.compromiso_de_entrega_id, factura_id: @contenedor_de_remision.factura_id } }
    assert_redirected_to contenedor_de_remision_url(@contenedor_de_remision)
  end

  test "should destroy contenedor_de_remision" do
    assert_difference('ContenedorDeRemision.count', -1) do
      delete contenedor_de_remision_url(@contenedor_de_remision)
    end

    assert_redirected_to contenedor_de_remisiones_url
  end
end
