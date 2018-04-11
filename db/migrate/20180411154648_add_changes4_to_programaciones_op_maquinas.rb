class AddChanges4ToProgramacionesOpMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :programaciones_op_maquinas, :tirajes_por_hora, :integer,default: 0
  end
end
