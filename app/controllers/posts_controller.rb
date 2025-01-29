class PostsController < ApplicationController
  before_action :require_login, only: [:index, :new]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]
    
    if @post.save
      redirect_to menu_users_path, notice: "Post created!!"
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end  
  end

  private

  def post_params
    params.require(:post).permit( :post_name, :post_content, :is_public)
  end
end