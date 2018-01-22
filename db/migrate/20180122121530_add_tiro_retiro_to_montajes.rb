class AddTiroRetiroToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :tiro, :boolean
    add_column :montajes, :retiro, :boolean
  end
end
