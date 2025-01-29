class SessionsController < ApplicationController
  
    def new
    end
  
    def create
      user = User.find_by(email: params[:login][:email])
      if user && user.authenticate(params[:login][:password]) && user.is_confirmed == true
        session[:user_id] = user.id
        redirect_to posts_path
      else
        flash.now[:alert] = "Incorrect email or password, try again."
        render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
      end
    end
  
    def destroy
      session.delete(:user_id)
      redirect_to root_path, notice: "Logged out!"
    end
    
  end