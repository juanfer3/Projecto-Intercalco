class AddCutterDeOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :habilitar_corte_de_material, :boolean, default: false
    add_column :ordenes_produccion, :sacar_de_inventario, :boolean, default: false
  end
end
