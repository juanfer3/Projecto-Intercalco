class CreateFacturas < ActiveRecord::Migration[5.1]
  def change
    create_table :facturas do |t|
      t.references :orden_produccion, foreign_key: true
      t.string :numero_de_factura, default: ""
      t.float :iva, default: 0.0
      t.float :descuento, default: 0.0
      t.float :total_facturado, default: 0.0
      t.boolean :cancelada, default: false

      t.timestamps
    end
  end
end
