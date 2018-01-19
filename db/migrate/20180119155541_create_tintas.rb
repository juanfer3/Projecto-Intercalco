class CreateTintas < ActiveRecord::Migration[5.1]
  def change
    create_table :tintas do |t|
      t.references :linea_de_color, foreign_key: true
      t.string :descripcion
      t.string :codigo
      t.boolean :formulado
      t.boolean :estado

      t.timestamps
    end
  end
end
