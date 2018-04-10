class RemoveChanges2ToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    remove_column :programaciones_op_maquinas, :tiempo_por_maquina, :time
    remove_column :programaciones_op_maquinas, :total_hora, :time
  end
end
