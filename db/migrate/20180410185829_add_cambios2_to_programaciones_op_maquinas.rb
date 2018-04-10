class AddCambios2ToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :programaciones_op_maquinas, :tiempo_por_maquina, :float, default: 0.0
    add_column :programaciones_op_maquinas, :total_hora, :float, default: 0.0
  end
end
