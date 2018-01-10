class AddTotalToPedidos < ActiveRecord::Migration[5.1]
  def change
    add_column :pedidos, :cantidad_total, :float
  end
end
