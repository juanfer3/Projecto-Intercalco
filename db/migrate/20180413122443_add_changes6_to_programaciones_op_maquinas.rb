class AddChanges6ToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :programaciones_op_maquinas, :fecha_de_impresion_final, :date
  end
end
