require 'test_helper'

class DesarrollosDeTintasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @desarrollo_de_tinta = desarrollos_de_tintas(:one)
  end

  test "should get index" do
    get desarrollos_de_tintas_url
    assert_response :success
  end

  test "should get new" do
    get new_desarrollo_de_tinta_url
    assert_response :success
  end

  test "should create desarrollo_de_tinta" do
    assert_difference('DesarrolloDeTinta.count') do
      post desarrollos_de_tintas_url, params: { desarrollo_de_tinta: { cantidad: @desarrollo_de_tinta.cantidad, descripción: @desarrollo_de_tinta.descripción, estado: @desarrollo_de_tinta.estado, linea_de_color_id: @desarrollo_de_tinta.linea_de_color_id, malla_id: @desarrollo_de_tinta.malla_id, montaje_id: @desarrollo_de_tinta.montaje_id, retiro: @desarrollo_de_tinta.retiro, tiro: @desarrollo_de_tinta.tiro } }
    end

    assert_redirected_to desarrollo_de_tinta_url(DesarrolloDeTinta.last)
  end

  test "should show desarrollo_de_tinta" do
    get desarrollo_de_tinta_url(@desarrollo_de_tinta)
    assert_response :success
  end

  test "should get edit" do
    get edit_desarrollo_de_tinta_url(@desarrollo_de_tinta)
    assert_response :success
  end

  test "should update desarrollo_de_tinta" do
    patch desarrollo_de_tinta_url(@desarrollo_de_tinta), params: { desarrollo_de_tinta: { cantidad: @desarrollo_de_tinta.cantidad, descripción: @desarrollo_de_tinta.descripción, estado: @desarrollo_de_tinta.estado, linea_de_color_id: @desarrollo_de_tinta.linea_de_color_id, malla_id: @desarrollo_de_tinta.malla_id, montaje_id: @desarrollo_de_tinta.montaje_id, retiro: @desarrollo_de_tinta.retiro, tiro: @desarrollo_de_tinta.tiro } }
    assert_redirected_to desarrollo_de_tinta_url(@desarrollo_de_tinta)
  end

  test "should destroy desarrollo_de_tinta" do
    assert_difference('DesarrolloDeTinta.count', -1) do
      delete desarrollo_de_tinta_url(@desarrollo_de_tinta)
    end

    assert_redirected_to desarrollos_de_tintas_url
  end
end
