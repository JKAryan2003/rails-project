class RegistrationsController < ApplicationController
  def new
    @user = User.new
    @roles = Role.all
  end

  def create

    binding.pry 
    @user = User.new(user_params)
    role_ids = params[:user][:roles]

    if role_ids.present?
      role_ids.map!{|role_id| role_id.to_i}
      @user.roles = Role.where(id: role_ids)
    end


    if @user.save 
      UserMailer.confirmation_email(@user).deliver_now
      session[:user_id]=@user.id
      redirect_to menu_users_path,notice: "User Created Successfully!"

    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end


  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end
end