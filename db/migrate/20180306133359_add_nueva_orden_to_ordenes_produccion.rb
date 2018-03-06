class AddNuevaOrdenToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :orden_nueva, :boolean, default: false
  end
end
