class CreateTiemposDeEntregas < ActiveRecord::Migration[5.1]
  def change
    create_table :tiempos_de_entregas do |t|
      t.references :pedido, foreign_key: true
      t.float :cantidad, default: 0.0
      t.date :fecha_compromiso
      t.float :precio, default: 0.0
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
