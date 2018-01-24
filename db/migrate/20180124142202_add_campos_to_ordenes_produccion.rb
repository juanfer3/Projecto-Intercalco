class AddCamposToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :tamano_hoja, :float
    add_column :ordenes_produccion, :tamano_por_hojas, :float
    add_column :ordenes_produccion, :tamano_de_corte, :float
  end
end
