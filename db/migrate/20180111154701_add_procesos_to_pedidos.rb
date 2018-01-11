class AddProcesosToPedidos < ActiveRecord::Migration[5.1]
  def change
    add_column :pedidos, :pantalla, :boolean,  default: false
    add_column :pedidos, :color, :boolean,  default: false
    add_column :pedidos, :corte_material, :boolean,  default: false
    add_column :pedidos, :impresion, :boolean,  default: false
    add_column :pedidos, :troquel, :boolean,  default: false
    add_column :pedidos, :acabado, :boolean,  default: false
  end
end
