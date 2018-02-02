class RemoveUserToMontajes < ActiveRecord::Migration[5.1]
  def change
    remove_reference :montajes, :user, foreign_key: true
  end
end
