module ApplicationHelper
  def nombre_usuario
     User.where("id = ?", User.current_user.email).first.name if User.where("id = ?", User.current_user.email).first
  end
end
