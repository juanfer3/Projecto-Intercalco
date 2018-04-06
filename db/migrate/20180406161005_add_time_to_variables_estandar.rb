class AddTimeToVariablesEstandar < ActiveRecord::Migration[5.1]
  def change
    add_column :variables_estandar, :tiempo_de_desmontaje, :time
  end
end
