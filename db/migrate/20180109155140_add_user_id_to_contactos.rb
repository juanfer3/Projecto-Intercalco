class AddUserIdToContactos < ActiveRecord::Migration[5.1]
  def change
    add_reference :contactos, :user, foreign_key: true
  end
end
