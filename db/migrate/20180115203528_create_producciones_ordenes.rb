class CreateProduccionesOrdenes < ActiveRecord::Migration[5.1]
  def change
    create_table :producciones_ordenes do |t|
      t.references :cliente, foreign_key: true
      t.references :user, foreign_key: true
      t.references :maquina, foreign_key: true
      t.references :montaje, foreign_key: true
      t.references :pieza_a_decorar, foreign_key: true
      t.string :numero_de_orden
      t.string :mes
      t.float :cantidad_programada
      t.float :precio_unitario
      t.float :valor_total
      t.string :tipo_de_produccion
      t.float :tamanos_total
      t.float :cavidad
      t.string :tipo_de_linea
      t.date :fecha
      t.date :fecha_compromiso
      t.float :cantidad_hoja
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
      t.string :estado_de_orde
      t.boolean :estado

      t.timestamps
    end
  end
end
