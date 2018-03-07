class AddObservacionesToCompromisosDeEntrega < ActiveRecord::Migration[5.1]
  def change
    add_column :compromisos_de_entrega, :observacion, :string, default: ""
  end
end
