class CreatePiezasADecorar < ActiveRecord::Migration[5.1]
  def change
    create_table :piezas_a_decorar do |t|
      t.string :nombre
      t.string :descripccion
      t.boolean :estado

      t.timestamps
    end
  end
end
