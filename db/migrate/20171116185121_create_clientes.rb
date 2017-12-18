class CreateClientes < ActiveRecord::Migration[5.1]
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :nit
      t.string :direccion
      t.string :telefono
      t.string :correo
      t.references :user, foreign_key: true
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
