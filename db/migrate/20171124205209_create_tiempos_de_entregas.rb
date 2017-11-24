class CreateTiemposDeEntregas < ActiveRecord::Migration[5.1]
  def change
    create_table :tiempos_de_entregas do |t|
      t.references :pedido, foreign_key: true
      t.float :cantidad
      t.date :fecha_compromiso
      t.float :precio
      t.boolean :estado

      t.timestamps
    end
  end
end
