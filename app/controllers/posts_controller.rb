class PostsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  http_basic_authenticate_with name: 'admin', password: 'password', except: [:index, :show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end


  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

private

  def record_not_found
    render 'public/404', :status => 404
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end




end
