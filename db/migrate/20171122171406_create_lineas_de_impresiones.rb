class CreateLineasDeImpresiones < ActiveRecord::Migration[5.1]
  def change
    create_table :lineas_de_impresiones do |t|
      t.string :tipo_de_linea
      t.string :descripcion
      t.boolean :estado

      t.timestamps
    end
  end
end
