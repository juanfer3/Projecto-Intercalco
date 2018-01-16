require 'test_helper'

class FormatosOpControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formato_op = formatos_op(:one)
  end

  test "should get index" do
    get formatos_op_url
    assert_response :success
  end

  test "should get new" do
    get new_formato_op_url
    assert_response :success
  end

  test "should create formato_op" do
    assert_difference('FormatoOp.count') do
      post formatos_op_url, params: { formato_op: { cantidad_hoja: @formato_op.cantidad_hoja, cavidad: @formato_op.cavidad, estado: @formato_op.estado, linea_de_color_id: @formato_op.linea_de_color_id, linea_producto_id: @formato_op.linea_producto_id, maquina_id: @formato_op.maquina_id, material: @formato_op.material, montaje_id: @formato_op.montaje_id, observacion: @formato_op.observacion, pieza_a_decorar_id: @formato_op.pieza_a_decorar_id, referencia_de_orden: @formato_op.referencia_de_orden, tamanos_total: @formato_op.tamanos_total, temperatura: @formato_op.temperatura, tipo_de_linea: @formato_op.tipo_de_linea, tipo_de_produccion: @formato_op.tipo_de_produccion, user_id: @formato_op.user_id } }
    end

    assert_redirected_to formato_op_url(FormatoOp.last)
  end

  test "should show formato_op" do
    get formato_op_url(@formato_op)
    assert_response :success
  end

  test "should get edit" do
    get edit_formato_op_url(@formato_op)
    assert_response :success
  end

  test "should update formato_op" do
    patch formato_op_url(@formato_op), params: { formato_op: { cantidad_hoja: @formato_op.cantidad_hoja, cavidad: @formato_op.cavidad, estado: @formato_op.estado, linea_de_color_id: @formato_op.linea_de_color_id, linea_producto_id: @formato_op.linea_producto_id, maquina_id: @formato_op.maquina_id, material: @formato_op.material, montaje_id: @formato_op.montaje_id, observacion: @formato_op.observacion, pieza_a_decorar_id: @formato_op.pieza_a_decorar_id, referencia_de_orden: @formato_op.referencia_de_orden, tamanos_total: @formato_op.tamanos_total, temperatura: @formato_op.temperatura, tipo_de_linea: @formato_op.tipo_de_linea, tipo_de_produccion: @formato_op.tipo_de_produccion, user_id: @formato_op.user_id } }
    assert_redirected_to formato_op_url(@formato_op)
  end

  test "should destroy formato_op" do
    assert_difference('FormatoOp.count', -1) do
      delete formato_op_url(@formato_op)
    end

    assert_redirected_to formatos_op_url
  end
end
