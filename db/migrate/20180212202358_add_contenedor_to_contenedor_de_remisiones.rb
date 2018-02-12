class AddContenedorToContenedorDeRemisiones < ActiveRecord::Migration[5.1]
  def change
    add_reference :contenedor_de_remisiones, :contenedor_de_ordenes, foreign_key: true
  end
end
