require 'test_helper'

class MaterialesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @material = materiales(:one)
  end

  test "should get index" do
    get materiales_url
    assert_response :success
  end

  test "should get new" do
    get new_material_url
    assert_response :success
  end

  test "should create material" do
    assert_difference('Material.count') do
      post materiales_url, params: { material: { cantidad: @material.cantidad, codigo: @material.codigo, descripcion: @material.descripcion, estado: @material.estado, medida_material: @material.medida_material } }
    end

    assert_redirected_to material_url(Material.last)
  end

  test "should show material" do
    get material_url(@material)
    assert_response :success
  end

  test "should get edit" do
    get edit_material_url(@material)
    assert_response :success
  end

  test "should update material" do
    patch material_url(@material), params: { material: { cantidad: @material.cantidad, codigo: @material.codigo, descripcion: @material.descripcion, estado: @material.estado, medida_material: @material.medida_material } }
    assert_redirected_to material_url(@material)
  end

  test "should destroy material" do
    assert_difference('Material.count', -1) do
      delete material_url(@material)
    end

    assert_redirected_to materiales_url
  end
end
