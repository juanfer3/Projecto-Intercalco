class AddCamposAcabadosToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :precorte, :boolean
    add_column :montajes, :pretroquelado, :boolean
    add_column :montajes, :laminado, :boolean
    add_column :montajes, :troquelado, :boolean
    add_column :montajes, :descalerillado, :boolean
    add_column :montajes, :plotter, :boolean
    add_column :montajes, :doming, :boolean
    add_column :montajes, :descolille, :boolean
    add_column :montajes, :doblez_calor, :boolean
    add_column :montajes, :termoformado, :boolean
    add_column :montajes, :estampado_al_calor, :boolean
    add_column :montajes, :refilado, :boolean
    add_column :montajes, :perforado, :boolean
    add_column :montajes, :ojalete, :boolean
    add_column :montajes, :hilo, :boolean
    add_column :montajes, :pegado, :boolean
    add_column :montajes, :ensamblado, :boolean
    add_column :montajes, :otro, :string
  end
end
