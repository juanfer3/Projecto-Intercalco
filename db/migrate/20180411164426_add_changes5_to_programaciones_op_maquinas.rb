class AddChanges5ToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :programaciones_op_maquinas, :fecha_de_impresion, :date
  end
end
