class RemoveChangesToVariablesEstandar < ActiveRecord::Migration[5.1]
  def change
    remove_column :variables_estandar, :tiempo_de_desmontaje, :time
    remove_column :variables_estandar, :tiempo_de_montaje, :datetime
  end
end
