class CreateContactos < ActiveRecord::Migration[5.1]
  def change
    create_table :contactos do |t|
      t.string :nombre_contacto, default: ""
      t.string :telefono, default: ""
      t.string :celular, default: ""
      t.string :correo, default: ""
      t.references :cliente, foreign_key: true
      t.boolean :estado, default: true

      t.timestamps
    end
  end
end
