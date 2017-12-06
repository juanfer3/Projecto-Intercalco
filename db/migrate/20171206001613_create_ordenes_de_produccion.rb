class CreateOrdenesDeProduccion < ActiveRecord::Migration[5.1]
  def change
    create_table :ordenes_de_produccion do |t|
      t.references :pedido, foreign_key: true
      t.string :numero_de_orden, default: ""
      t.string :descripcion, default: ""
      t.date :fecha_final
      t.float :total, default: 0.0
      t.string :codigo, default: ""
      t.float :cantidad, default: 0.0
      t.date :fecha
      t.string :inventario, default: ""
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
