class AddNumOrdenToTransiciones < ActiveRecord::Migration[5.1]
  def change
    add_reference :transiciones, :orden_produccion, foreign_key: true
  end
end
