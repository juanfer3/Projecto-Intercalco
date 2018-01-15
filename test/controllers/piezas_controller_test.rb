require 'test_helper'

class PiezasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pieza = piezas(:one)
  end

  test "should get index" do
    get piezas_url
    assert_response :success
  end

  test "should get new" do
    get new_pieza_url
    assert_response :success
  end

  test "should create pieza" do
    assert_difference('Pieza.count') do
      post piezas_url, params: { pieza: { cantidad: @pieza.cantidad, descripcion: @pieza.descripcion, dimension: @pieza.dimension, estado: @pieza.estado, montaje_id: @pieza.montaje_id, nombre: @pieza.nombre, tamano: @pieza.tamano, tipo_de_unidad: @pieza.tipo_de_unidad } }
    end

    assert_redirected_to pieza_url(Pieza.last)
  end

  test "should show pieza" do
    get pieza_url(@pieza)
    assert_response :success
  end

  test "should get edit" do
    get edit_pieza_url(@pieza)
    assert_response :success
  end

  test "should update pieza" do
    patch pieza_url(@pieza), params: { pieza: { cantidad: @pieza.cantidad, descripcion: @pieza.descripcion, dimension: @pieza.dimension, estado: @pieza.estado, montaje_id: @pieza.montaje_id, nombre: @pieza.nombre, tamano: @pieza.tamano, tipo_de_unidad: @pieza.tipo_de_unidad } }
    assert_redirected_to pieza_url(@pieza)
  end

  test "should destroy pieza" do
    assert_difference('Pieza.count', -1) do
      delete pieza_url(@pieza)
    end

    assert_redirected_to piezas_url
  end
end
