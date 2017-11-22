class CreateContactos < ActiveRecord::Migration[5.1]
  def change
    create_table :contactos do |t|
      t.string :nombre_contacto
      t.string :telefono
      t.string :celular
      t.string :correo
      t.references :cliente, foreign_key: true
      t.boolean :estado

      t.timestamps
    end
  end
end
