class AddInputsMaterialToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :material, :string
  end
end
