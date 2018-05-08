class AddChanges3ToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :habilitar_preprensa, :boolean, default: true
  end
end
