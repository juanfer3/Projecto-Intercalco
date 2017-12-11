class CreateFacturasDespacho < ActiveRecord::Migration[5.1]
  def change
    create_table :facturas_despacho do |t|
      t.references :pedido, foreign_key: true
      t.string :numero_de_factura, default: ""
      t.boolean :cancelada, default: true
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
