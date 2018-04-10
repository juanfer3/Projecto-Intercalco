class AddCambiosToVariablesEstandar < ActiveRecord::Migration[5.1]
  def change
    add_column :variables_estandar, :tiempo_de_desmontaje, :float, default: 0.0
    add_column :variables_estandar, :tiempo_de_montaje, :float, default: 0.0
  end
end
