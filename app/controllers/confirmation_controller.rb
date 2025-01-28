class ConfirmationController < ApplicationController
  def edit
    user = User.find_by(id: params[:id])
    user.update(is_confirmed: true)
    session[:user_id] = user.id
    redirect_to menu_users_path
  end
end