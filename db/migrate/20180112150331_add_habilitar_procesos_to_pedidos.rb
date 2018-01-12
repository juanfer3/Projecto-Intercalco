class AddHabilitarProcesosToPedidos < ActiveRecord::Migration[5.1]
  def change
    add_column :pedidos, :habilitar_impresion, :boolean, default: true
    add_column :pedidos, :habilitar_acabado, :boolean, default: true
  end
end
