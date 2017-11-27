class CreateLineasDeImpresiones < ActiveRecord::Migration[5.1]
  def change
    create_table :lineas_de_impresiones do |t|
      t.string :tipo_de_linea, default: ""
      t.string :descripcion, default: ""
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
