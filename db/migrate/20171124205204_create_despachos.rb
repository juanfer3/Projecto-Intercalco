class CreateDespachos < ActiveRecord::Migration[5.1]
  def change
    create_table :despachos do |t|
      t.references :pedido, foreign_key: true
      t.string :nombre
      t.string :nit
      t.string :telefono
      t.string :lugar_de_despacho
      t.string :direccion
      t.string :celular
      t.string :correo
      t.string :recibe
      t.string :observacion
      t.string :facturar
      t.boolean :estado

      t.timestamps
    end
  end
end
