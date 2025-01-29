class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  protect_from_forgery with: :exception
  helper_method :current_user
  helper_method :is_admin
  helper_method :logged_in
  helper_method :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end
  
  def is_admin
    current_user.roles.exists?(role_name: 'Admin')
  end

  def require_login
    if logged_in?
      true
    else
      redirect_to login_path, alert: "You must be logged in to view this page."
    end
  end
end
