class RemoveChanges3ToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    remove_column :programaciones_op_maquinas, :tiempo_por_maquina, :float
    remove_column :programaciones_op_maquinas, :total_hora, :float
  end
end
