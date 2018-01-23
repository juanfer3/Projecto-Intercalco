class CreateCompromisosDeEntrega < ActiveRecord::Migration[5.1]
  def change
    create_table :compromisos_de_entrega do |t|
      t.references :orden_produccion, foreign_key: true
      t.date :fecha_de_compromiso
      t.float :cantidad
      t.float :precio
      t.date :fecha_despacho
      t.float :cantidad_despacho
      t.float :precio_despacho
      t.float :diferencia
      t.string :numero_de_remision
      t.boolean :estado

      t.timestamps
    end
  end
end
