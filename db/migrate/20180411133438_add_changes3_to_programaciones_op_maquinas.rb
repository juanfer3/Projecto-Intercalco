class AddChanges3ToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :programaciones_op_maquinas, :tiempo_por_maquina, :string, default: ""
    add_column :programaciones_op_maquinas, :total_hora, :string, default: ""
  end
end
