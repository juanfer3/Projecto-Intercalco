class AddCambiosToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :programaciones_op_maquinas, :tiempo_de_desmontaje, :float, default: 0.0
    add_column :programaciones_op_maquinas, :tiempo_de_montaje, :float, default: 0.0
  end
end
