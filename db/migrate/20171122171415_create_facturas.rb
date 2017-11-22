class CreateFacturas < ActiveRecord::Migration[5.1]
  def change
    create_table :facturas do |t|
      t.references :cliente, foreign_key: true
      t.string :nombre
      t.string :nit
      t.string :telefono
      t.string :lugar_de_factura
      t.string :telefono
      t.string :celular
      t.string :correo
      t.string :recibe
      t.boolean :estado

      t.timestamps
    end
  end
end
