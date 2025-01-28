class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :is_admin

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin
    @user ||= User.find(session[:user_id]) if session[:user_id]
    if @user && @user.roles.exists?(role_name: 'Admin')
      true
    else
      false
    end
  end
end
