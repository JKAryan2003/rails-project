class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)
    role_ids = params[:user][:roles]

    if @user.save 

      role_ids.each do |role_id|
        UserRole.create(user_id:@user.id,role_id: role_id)
      end
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
    # user_role = user.roles
    # @roles.each do |role|
    #   user_role = Role.find_by(id: params[:id])
    # end
    # user.role = Role.find_by(id: params[:id])

  end

  def update
    user
    role_ids = params[:user][:roles]
    if user.update(user_params)
      role_ids.each do |role_id|
        if !UserRole.find(role_id)
          UserRole.create(user_id:@user.id,role_id: role_id)
        end
      end
      redirect_to users_path,notice: "Updated!!"
    else
      render :edit
    end
  end
  
  def destroy
    user
    user.destroy()
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