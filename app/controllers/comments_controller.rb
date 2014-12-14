class CommentsController < ApplicationController

  #http_basic_authenticate_with name: "admin", password: "password", only: :destroy

  before_filter :if_admin?, only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

    def if_admin?
      unless current_admin!=nil
        flash[:error] = "You must be admin to access this action"
       redirect_to posts_path
      end

    end

    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
