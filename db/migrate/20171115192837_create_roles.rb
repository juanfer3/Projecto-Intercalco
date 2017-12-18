class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :cargo
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
