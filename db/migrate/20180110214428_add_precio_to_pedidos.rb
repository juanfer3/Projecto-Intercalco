class AddPrecioToPedidos < ActiveRecord::Migration[5.1]
  def change
    add_column :pedidos, :precio_total, :float
  end
end
