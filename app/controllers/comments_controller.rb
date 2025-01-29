class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @posts = Post.all
    @comment = Comment.new(comment_params)  
    @comment.user = current_user
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to menu_users_path,notice: "Comment Added!!"
    else
      flash.now[:alert] = @comment.errors.full_messages.to_sentence
      render turbo_stream: [turbo_stream.update("flash", partial: "shared/flash")]
    end 
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end