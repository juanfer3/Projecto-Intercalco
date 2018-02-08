class CreateContenedorDeRemisiones < ActiveRecord::Migration[5.1]
  def change
    create_table :contenedor_de_remisiones do |t|
      t.references :factura, foreign_key: true
      t.references :compromiso_de_entrega, foreign_key: true

      t.timestamps
    end
  end
end
