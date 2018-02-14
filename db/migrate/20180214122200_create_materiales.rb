class CreateMateriales < ActiveRecord::Migration[5.1]
  def change
    create_table :materiales do |t|
      t.string :codigo
      t.string :descripcion
      t.string :medida_material
      t.float :cantidad
      t.boolean :estado

      t.timestamps
    end
  end
end
