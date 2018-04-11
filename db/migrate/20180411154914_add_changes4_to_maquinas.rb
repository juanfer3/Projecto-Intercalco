class AddChanges4ToMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :maquinas, :tirajes_por_hora, :integer,default: 0
    add_column :maquinas, :complemento, :float,default: 0.0
  end
end
