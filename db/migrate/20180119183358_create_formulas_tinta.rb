class CreateFormulasTinta < ActiveRecord::Migration[5.1]
  def change
    create_table :formulas_tinta do |t|
      t.references :tinta_formulada, foreign_key: true
      t.references :tinta, foreign_key: true
      t.float :porcentaje
      t.boolean :estado

      t.timestamps
    end
  end
end
