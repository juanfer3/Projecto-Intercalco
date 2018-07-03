class CreateProcesosMaquinas < ActiveRecord::Migration[5.1]
  def change


    
    create_table :procesos_maquinas do |t|
      t.references :orden_produccion, foreign_key: true
      t.references :contenedor_de_maquinas, foreign_key: true
      t.boolean :cerrado

      t.timestamps
    end
  end
end
