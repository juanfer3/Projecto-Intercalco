class CreateFacturasDespacho < ActiveRecord::Migration[5.1]
  def change
    create_table :facturas_despacho do |t|
      t.references :tiempos_de_entrega, foreign_key: true
      t.string :numero_de_factura
      t.float :total_facturado
      t.float :iva
      t.float :descuento
      t.boolean :cancelada
      t.float :cantidad_faltante
      t.float :total_enviado
      t.boolean :estado

      t.timestamps
    end
  end
end
