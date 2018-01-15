class AddFechaDeCreacionToPiezas < ActiveRecord::Migration[5.1]
  def change
    add_column :piezas, :fecha_de_creacion, :date
  end
end
