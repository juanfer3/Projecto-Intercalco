class AddCamposMachineToMaquinas < ActiveRecord::Migration[5.1]
  def change
    add_column :maquinas, :unidad, :integer, default:0
  end
end
