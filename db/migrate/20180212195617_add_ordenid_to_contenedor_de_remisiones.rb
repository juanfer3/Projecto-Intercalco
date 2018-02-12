class AddOrdenidToContenedorDeRemisiones < ActiveRecord::Migration[5.1]
  def change
    add_reference :contenedor_de_remisiones, :orden_produccion, foreign_key: true
  end
end
