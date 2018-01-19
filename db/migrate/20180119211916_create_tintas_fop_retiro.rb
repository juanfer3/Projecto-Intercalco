class CreateTintasFopRetiro < ActiveRecord::Migration[5.1]
  def change
    create_table :tintas_fop_retiro do |t|
      t.references :montaje, foreign_key: true
      t.string :tinta
      t.references :malla, foreign_key: true
      t.string :descripcion
      t.boolean :estado

      t.timestamps
    end
  end
end
