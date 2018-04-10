class RemoveChangesToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    remove_column :programaciones_op_maquinas, :tiempo_de_desmontaje, :time
    remove_column :programaciones_op_maquinas, :tiempo_de_montaje, :time
  end
end
