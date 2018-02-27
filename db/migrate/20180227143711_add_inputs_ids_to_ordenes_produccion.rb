class AddInputsIdsToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_reference :ordenes_produccion, :lugar_despacho, foreign_key: true
    add_reference :ordenes_produccion, :nombre_facturacion, foreign_key: true
  end
end
