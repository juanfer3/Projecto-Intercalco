require 'test_helper'

class MontajesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @montaje = montajes(:one)
  end

  test "should get index" do
    get montajes_url
    assert_response :success
  end

  test "should get new" do
    get new_montaje_url
    assert_response :success
  end

  test "should create montaje" do
    assert_difference('Montaje.count') do
      post montajes_url, params: { montaje: { cantidad_total: @montaje.cantidad_total, cliente_id: @montaje.cliente_id, codigo: @montaje.codigo, dimension: @montaje.dimension, dimension_1: @montaje.dimension_1, dimension_2: @montaje.dimension_2, estado: @montaje.estado, nombre: @montaje.nombre, numero_de_montaje: @montaje.numero_de_montaje, observacion: @montaje.observacion, tamano: @montaje.tamano, tipo_de_unidad: @montaje.tipo_de_unidad } }
    end

    assert_redirected_to montaje_url(Montaje.last)
  end

  test "should show montaje" do
    get montaje_url(@montaje)
    assert_response :success
  end

  test "should get edit" do
    get edit_montaje_url(@montaje)
    assert_response :success
  end

  test "should update montaje" do
    patch montaje_url(@montaje), params: { montaje: { cantidad_total: @montaje.cantidad_total, cliente_id: @montaje.cliente_id, codigo: @montaje.codigo, dimension: @montaje.dimension, dimension_1: @montaje.dimension_1, dimension_2: @montaje.dimension_2, estado: @montaje.estado, nombre: @montaje.nombre, numero_de_montaje: @montaje.numero_de_montaje, observacion: @montaje.observacion, tamano: @montaje.tamano, tipo_de_unidad: @montaje.tipo_de_unidad } }
    assert_redirected_to montaje_url(@montaje)
  end

  test "should destroy montaje" do
    assert_difference('Montaje.count', -1) do
      delete montaje_url(@montaje)
    end

    assert_redirected_to montajes_url
  end
end
