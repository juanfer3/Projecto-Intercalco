class AddTipoDeUnidadToMateriales < ActiveRecord::Migration[5.1]
  def change
    add_column :materiales, :tipo_de_unidad, :string, default: ""
  end
end
