class CreateTintasFormuladas < ActiveRecord::Migration[5.1]
  def change
    create_table :tintas_formuladas do |t|
      t.references :linea_de_color, foreign_key: true
      t.references :malla, foreign_key: true
      t.string :codigo
      t.string :descripcion
      t.string :pantone
      t.float :cantidad_total
      t.boolean :estado

      t.timestamps
    end
  end
end
