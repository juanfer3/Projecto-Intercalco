class CreateLineasProductos < ActiveRecord::Migration[5.1]
  def change
    create_table :lineas_productos do |t|
      t.string :nombre
      t.string :descripcion
      t.boolean :estado

      t.timestamps
    end
  end
end
