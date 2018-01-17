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
      t.boolean :pantalla, default: true
      t.boolean :color, default: false
      t.boolean :corte_material, default: false
      t.boolean :impresion, default: false
      t.boolean :troquel, default: false
      t.boolean :acabado, default: false
      t.boolean :habilitar_impresion, default: true
      t.boolean :habilitar_acabado, default: true
      t.string :estado_de_orden, default: false
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
