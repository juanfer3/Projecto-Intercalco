class AddCorreccioncamposToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :tamano_hoja, :string
    add_column :ordenes_produccion, :tamano_de_corte, :string
  end
end
