class ApplicationController < ActionController::Base


  #protect_from_forgery with: :null_session

  protect_from_forgery with: :exception

  before_action :set_current_user

  def set_current_user
    User.current_user = current_user
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
    user_params.permit({ role_ids: [] }, :email, :password, :password_confirmation, :name)
  end

  devise_parameter_sanitizer.permit(:account_update) do |user_params|
    user_params.permit({ role_ids: [] }, :email, :password, :current_password,
                                       :password_confirmation, :name)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:warning] = exception.default_message = "No tienes permisos para acceder a esta página."
    redirect_to root_path
  end



  protected
  def authenticate_user!
    if user_signed_in?
      redirect_to home_path, :notice => 'if you want to add a notice'

      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end


end
