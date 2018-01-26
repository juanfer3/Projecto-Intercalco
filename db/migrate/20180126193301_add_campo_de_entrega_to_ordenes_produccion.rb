class AddCampoDeEntregaToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :entregado, :boolean, default:false
  end
end
