class RemoveOrdenToFacturas < ActiveRecord::Migration[5.1]
  def change
    remove_reference :facturas, :orden_produccion, foreign_key: true
  end
end
