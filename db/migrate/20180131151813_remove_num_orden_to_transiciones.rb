class RemoveNumOrdenToTransiciones < ActiveRecord::Migration[5.1]
  def change
    remove_reference :transiciones, :orden_produccion, foreign_key: true
  end
end
