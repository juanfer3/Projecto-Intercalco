class CreateClientes < ActiveRecord::Migration[5.1]
  def change
    create_table :clientes do |t|
      t.string :nombre, default: ""
      t.string :nit, default: ""
      t.string :direccion, default: ""
      t.string :telefono, default: ""
      t.string :correo, default: ""
      t.references :user, foreign_key: true
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
