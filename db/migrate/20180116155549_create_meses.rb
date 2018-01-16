class CreateMeses < ActiveRecord::Migration[5.1]
  def change
    create_table :meses do |t|
      t.string :nombre
      t.integer :dias
      t.string :observacion
      t.boolean :estado

      t.timestamps
    end
  end
end
