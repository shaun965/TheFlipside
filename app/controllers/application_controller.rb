class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def show_image
    @user = User.find(params[:id])
    send_data @user.image, :type => 'image/png',:disposition => 'inline'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :password, :password_confirmation, :remember_me, :update, :avatar) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:first_name, :last_name, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :password, :password_confirmation, :current_password) }
  end
end
