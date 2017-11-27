class CreateDespachos < ActiveRecord::Migration[5.1]
  def change
    create_table :despachos do |t|
      t.references :pedido, foreign_key: true
      t.string :nombre, default: ""
      t.string :nit, default: ""
      t.string :telefono, default: ""
      t.string :lugar_de_despacho, default: ""
      t.string :direccion, default: ""
      t.string :celular, default: ""
      t.string :correo, default: ""
      t.string :recibe, default: ""
      t.string :observacion, default: ""
      t.string :facturar, default: ""
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
