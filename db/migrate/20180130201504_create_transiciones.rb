class CreateTransiciones < ActiveRecord::Migration[5.1]
  def change
    create_table :transiciones do |t|
      t.references :desarrollo_de_tinta, foreign_key: true
      t.references :tinta_formulada, foreign_key: true

      t.timestamps
    end
  end
end
