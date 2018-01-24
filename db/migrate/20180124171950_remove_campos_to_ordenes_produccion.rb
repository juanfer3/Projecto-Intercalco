class RemoveCamposToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    remove_column :ordenes_produccion, :tamano_hoja, :float
    remove_column :ordenes_produccion, :tamano_de_corte, :float
  end
end
