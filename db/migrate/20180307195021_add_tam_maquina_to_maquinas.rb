class AddTamMaquinaToMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :maquinas, :formato_de_tamaño, :string, default: ""
  end
end
