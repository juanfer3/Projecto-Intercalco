class CreateTintasFopTiro < ActiveRecord::Migration[5.1]
  def change
    create_table :tintas_fop_tiro do |t|
      t.references :formato_op, foreign_key: true
      t.references :malla, foreign_key: true
      t.string :tipo_de_tinta
      t.string :color
      t.boolean :estado

      t.timestamps
    end
  end
end
