class AddModoDeEmpaqueToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :modo_de_empaque, :string
  end
end
