class AddChanges2ToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :administrador_maquina, :boolean, default: false
  end
end
