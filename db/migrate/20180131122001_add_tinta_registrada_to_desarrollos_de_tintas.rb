class AddTintaRegistradaToDesarrollosDeTintas < ActiveRecord::Migration[5.1]
  def change
    add_column :desarrollos_de_tintas, :tinta_registrada, :boolean, default: true
  end
end
