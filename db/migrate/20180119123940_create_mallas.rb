class CreateMallas < ActiveRecord::Migration[5.1]
  def change
    create_table :mallas do |t|
      t.string :nombre
      t.string :descripcion
      t.boolean :estado

      t.timestamps
    end
  end
end
