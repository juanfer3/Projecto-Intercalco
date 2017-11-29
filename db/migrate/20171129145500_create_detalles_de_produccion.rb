class CreateDetallesDeProduccion < ActiveRecord::Migration[5.1]
  def change
    create_table :detalles_de_produccion do |t|
      t.references :orden_de_produccion, foreign_key: true
      t.string :codigo
      t.string :descripcion
      t.string :cantidad
      t.date :fecha
      t.string :inventario
      t.boolean :estado

      t.timestamps
    end
  end
end
