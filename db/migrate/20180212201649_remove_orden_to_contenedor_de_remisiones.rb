class RemoveOrdenToContenedorDeRemisiones < ActiveRecord::Migration[5.1]
  def change
    remove_reference :contenedor_de_remisiones, :orden_produccion, foreign_key: true
    remove_reference :contenedor_de_remisiones, :factura, foreign_key: true
  end
end
