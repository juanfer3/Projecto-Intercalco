class CreateNombresFacturaciones < ActiveRecord::Migration[5.1]
  def change
    create_table :nombres_facturaciones do |t|
      t.references :cliente, foreign_key: true
      t.string :nombre
      t.string :direccion
      t.string :telefono

      t.timestamps
    end
  end
end
