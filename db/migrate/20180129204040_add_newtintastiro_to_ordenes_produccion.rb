class AddNewtintastiroToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :tinta_nueva_tiro, :boolean
    add_column :ordenes_produccion, :tinta_nueva_retiro, :boolean
  end
end
