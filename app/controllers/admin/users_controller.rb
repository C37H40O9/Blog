class Admin::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  before_filter :if_admin?, except: [:show, :index]

  def index
    @users = User.all
  end


  private

  def if_admin?
    unless current_user!=nil && current_user.admin?
      flash[:error] = "You must be admin to access this action"
      redirect_to posts_path
    end

  end

  def record_not_found
    render 'public/404', :status => 404
  end

  def post_params
    params.require(:post).permit(:title, :text, :photo, :tag_list)
  end

end