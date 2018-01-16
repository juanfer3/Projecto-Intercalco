class CreateFormatosOp < ActiveRecord::Migration[5.1]
  def change
    create_table :formatos_op do |t|
      t.references :user, foreign_key: true
      t.references :maquina, foreign_key: true
      t.references :montaje, foreign_key: true
      t.references :pieza_a_decorar, foreign_key: true
      t.string :referencia_de_orden
      t.references :linea_de_color, foreign_key: true
      t.string :tipo_de_produccion
      t.string :material
      t.string :temperatura
      t.float :tamanos_total
      t.float :cavidad
      t.string :tipo_de_linea
      t.float :cantidad_hoja
      t.string :observacion
      t.references :linea_producto, foreign_key: true
      t.boolean :estado

      t.timestamps
    end
  end
end
