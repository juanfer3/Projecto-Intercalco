class CreateDesarrollosDeTintas < ActiveRecord::Migration[5.1]
  def change
    create_table :desarrollos_de_tintas do |t|
      t.references :orden_produccion, foreign_key: true
      t.references :linea_de_color, foreign_key: true
      t.references :malla, foreign_key: true
      t.string :descripción
      t.float :cantidad
      t.boolean :estado
      t.boolean :tiro
      t.boolean :retiro

      t.timestamps
    end
  end
end
