class AddTiroAndRetiroToFormatosOp < ActiveRecord::Migration[5.1]
  def change
    add_column :formatos_op, :tiro, :boolean
    add_column :formatos_op, :retiro, :boolean
  end
end
