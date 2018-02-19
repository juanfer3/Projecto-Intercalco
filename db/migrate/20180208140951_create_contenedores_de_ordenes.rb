class CreateContenedoresDeOrdenes < ActiveRecord::Migration[5.1]
  def change
    create_table :contenedores_de_ordenes do |t|
      t.references :factura, foreign_key: true
      t.references :orden_produccion, foreign_key: true

      t.timestamps
    end
  end
end
