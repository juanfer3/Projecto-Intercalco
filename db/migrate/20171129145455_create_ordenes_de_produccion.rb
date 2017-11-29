class CreateOrdenesDeProduccion < ActiveRecord::Migration[5.1]
  def change
    create_table :ordenes_de_produccion do |t|
      t.references :pedido, foreign_key: true
      t.string :numero_de_orden
      t.string :descripcion
      t.date :fecha_final
      t.float :total
      t.boolean :estado

      t.timestamps
    end
  end
end
