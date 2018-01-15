class AddFechaDeCreacionToMontajes < ActiveRecord::Migration[5.1]
  def change
    add_column :montajes, :fecha_de_creacion, :date
  end
end
