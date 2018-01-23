class RemoveFopToOrdenesProduccion < ActiveRecord::Migration[5.1]
  def change
    remove_reference :ordenes_produccion, :formato_op, foreign_key: true
  end
end
