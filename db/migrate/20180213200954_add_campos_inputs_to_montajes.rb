class AddCamposInputsToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :tamano_hoja, :string
    add_column :montajes, :tamano_por_hojas, :float
    add_column :montajes, :tamano_de_corte, :string
  end
end
