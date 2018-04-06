class CreateProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    create_table :programaciones_op_maquinas do |t|
      t.references :orden_produccion, foreign_key: true
      t.references :maquina, foreign_key: true
      t.time :total_hora
      t.time :hora_inicio
      t.time :hora_final
      t.integer :cantidad_maquinas, default:0
      t.time :tiempo_por_maquina
      t.time :tiempo_de_montaje
      t.time :tiempo_de_desmontaje
      t.boolean :habilitado, default:true
      t.string :complemento, default:""

      t.timestamps
    end
  end
end
