class CreateMontajes < ActiveRecord::Migration[5.1]
  def change
    create_table :montajes do |t|
      t.references :cliente, foreign_key: true
      t.string :nombre
      t.string :tamano
      t.string :dimension
      t.float :dimension_1
      t.float :dimension_2
      t.string :codigo
      t.string :numero_de_montaje
      t.string :tipo_de_unidad
      t.float :cantidad_total
      t.string :observacion
      t.boolean :estado

      t.timestamps
    end
  end
end
