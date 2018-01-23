class AddMontajeToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    add_reference :ordenes_produccion, :montaje, foreign_key: true
  end
end
