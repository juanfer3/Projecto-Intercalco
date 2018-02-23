class AddMaqToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_reference :ordenes_produccion, :contacto, foreign_key: true
    add_column :ordenes_produccion, :facturar_a, :string
    add_column :ordenes_produccion, :orden_de_compra, :string
  end
end
