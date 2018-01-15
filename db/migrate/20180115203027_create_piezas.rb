class CreatePiezas < ActiveRecord::Migration[5.1]
  def change
    create_table :piezas do |t|
      t.references :montaje, foreign_key: true
      t.string :nombre
      t.string :tamano
      t.string :tipo_de_unidad
      t.string :dimension
      t.string :descripcion
      t.float :cantidad
      t.boolean :estado

      t.timestamps
    end
  end
end
