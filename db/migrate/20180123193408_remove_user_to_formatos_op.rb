class RemoveUserToFormatosOp < ActiveRecord::Migration[5.1]
  def change
    remove_reference :formatos_op, :user, foreign_key: true
  end
end
