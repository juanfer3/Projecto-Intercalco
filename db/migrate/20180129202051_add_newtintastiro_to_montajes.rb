class AddNewtintastiroToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :tinta_nueva_tiro, :boolean, default: false
    add_column :montajes, :tinta_nueva_retiro, :boolean, default: false
  end
end
