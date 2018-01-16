class CreateOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    create_table :ordenes_produccion do |t|
      t.references :formato_op, foreign_key: true
      t.string :numero_de_orden
      t.references :mes, foreign_key: true
      t.float :cantidad_programada
      t.float :precio_unitario
      t.float :valor_total
      t.string :tipo_de_produccion
      t.string :material
      t.string :temperatura
      t.float :tamanos_total
      t.float :cavidad
      t.date :fecha
      t.date :fecha_compromiso
      t.float :cantidad_hoja
      t.float :porcentaje_macula
      t.boolean :tiro
      t.boolean :retiro
      t.string :observacion
      t.boolean :pantalla
      t.boolean :color
      t.boolean :corte_material
      t.boolean :impresion
      t.boolean :troquel
      t.boolean :acabado
      t.boolean :habilitar_impresion
      t.boolean :habilitar_acabado
      t.string :estado_de_orden
      t.boolean :estado

      t.timestamps
    end
  end
end
