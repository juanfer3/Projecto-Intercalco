class AddInputsToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_reference :montajes, :linea_de_color, foreign_key: true
    add_reference :montajes, :maquina, foreign_key: true
    add_reference :montajes, :linea_producto, foreign_key: true
  end
end
