class AddValidacionDeEntregaToCompromisosDeEntrega < ActiveRecord::Migration[5.1]
  def change
    add_column :compromisos_de_entrega, :enviado, :boolean, default: false
    add_column :compromisos_de_entrega, :cumplido, :boolean, default: false
  end
end
