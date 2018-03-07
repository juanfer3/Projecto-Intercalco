class CreateMateriales < ActiveRecord::Migration[5.1]
  def change
    create_table :materiales do |t|
      t.string :codigo, default: ""
      t.string :descripcion, default: ""
      t.string :medida_material, default: ""
      t.float :cantidad, default: 0.0
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
