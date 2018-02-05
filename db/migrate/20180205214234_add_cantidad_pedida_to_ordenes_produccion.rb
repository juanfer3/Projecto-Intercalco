class AddCantidadPedidaToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :cantidad_solicitada, :float
  end
end
