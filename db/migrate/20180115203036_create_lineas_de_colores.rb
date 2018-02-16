class CreateLineasDeColores < ActiveRecord::Migration[5.1]
  def change
    create_table :lineas_de_colores do |t|
      t.string :nombre
      t.string :descripcion
      t.boolean :estado

      t.timestamps

    
    end
  end
end
