class CreateRemisiones < ActiveRecord::Migration[5.1]
  def change
    create_table :remisiones do |t|
      t.references :factura_despacho, foreign_key: true
      t.string :numero_de_remision
      t.date :fecha_de_despacho
      t.float :cantidad_enviada
      t.float :precio_a_facturar
      t.float :cantidad_faltante
      t.boolean :entrega_cumplida
      t.boolean :estado

      t.timestamps
    end
  end
end
