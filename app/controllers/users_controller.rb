class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    user
    @user = User.new(user_params)
    role_ids = params[:user][:roles]

    if role_ids.present?
      role_ids.map!{|role_id| role_id.to_i}
      @user.roles = Role.where(id: role_ids)
    end


    if @user.save 

      UserMailer.welcome_email(@user).deliver_now
      redirect_to users_path,notice: "User Created Successfully!"

    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end

  end

  def show
    user
    @roles = user.roles
  end

  def edit
    user
    @roles = Role.all

  end

  def update
    role_ids = params[:user][:roles]
    if user.update(user_params)
      role_ids.each do |role_id|
        if !UserRole.find_by(user_id: user.id, role_id: role_id)
          UserRole.create(user_id:@user.id,role_id: role_id)
        end
      end

      prev_ids = user.roles.map{ |role| role.id}

      prev_ids.each do |prev_role_id|
        if !role_ids.include?(prev_role_id.to_s)
          UserRole.find_by(user_id: user.id, role_id: prev_role_id).destroy
        end
      end
      redirect_to users_path,notice: "Updated!!"

      # binding.pry
    else
      render :edit
    end
  end
  
  def destroy
    user
    user.destroy

    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def user
    @user ||= User.find_by(id: params[:id])
  end

end