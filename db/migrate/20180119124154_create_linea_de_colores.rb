class CreateLineaDeColores < ActiveRecord::Migration[5.1]
  def change
    create_table :linea_de_colores do |t|
      t.string :nombre
      t.string :descripcion
      t.boolean :estado

      t.timestamps
    end
  end
end
