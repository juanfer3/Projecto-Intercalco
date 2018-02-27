class AddLugarDepachoToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_column :ordenes_produccion, :lugar_despacho, :string
  end
end
