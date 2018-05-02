class AddChanges2ToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :facturado, :boolean, default: false
  end
end
