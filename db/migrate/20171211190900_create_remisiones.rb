class CreateRemisiones < ActiveRecord::Migration[5.1]
  def change
    create_table :remisiones do |t|
      t.references :factura_despacho, foreign_key: true
      t.references :tiempos_de_entrega, foreign_key: true
      t.date :fecha_de_despacho
      t.float :cantidad_enviada, default: 0.0
      t.float :precio_a_facturar, default: 0.0
      t.float :cantidad_faltante, default: 0.0
      t.boolean :entrega_cumplida, default: true
      t.boolean :estado, default: true
      t.timestamps
    end
  end
end
