class AddTintaNuevaToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :tinta_nueva, :boolean
  end
end
