class CreateTiemposDeEntregas < ActiveRecord::Migration[5.1]
  def change
    create_table :tiempos_de_entregas do |t|
      t.references :pedido, foreign_key: true
      t.string :remision, default: ""
      t.float :cantidad, default: 0.0
      t.date :fecha_compromiso
      t.float :precio, default: 0.0
      t.date :fecha_de_despacho
      t.float :cantidad_enviada, default: 0.0
      t.float :precio_a_facturar, default: 0.0
      t.float :cantidad_faltante, default: 0.0
      t.boolean :anexo, default: false
      t.boolean :entrega_cumplida, default: false
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
