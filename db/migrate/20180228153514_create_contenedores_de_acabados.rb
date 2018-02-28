class CreateContenedoresDeAcabados < ActiveRecord::Migration[5.1]
  def change
    create_table :contenedores_de_acabados do |t|
      t.references :montaje, foreign_key: true
      t.references :acabado, foreign_key: true

      t.timestamps
    end
  end
end
