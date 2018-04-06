class CreateVariablesEstandar < ActiveRecord::Migration[5.1]
  def change
    create_table :variables_estandar do |t|
      t.datetime :tiempo_de_montaje

      t.timestamps
    end
  end
end
