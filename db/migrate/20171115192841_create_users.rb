class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :numero_celular
      t.references :rol, foreign_key: true
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
