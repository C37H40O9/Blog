class Admin::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  before_filter :if_admin?

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)


    if @user.save
      redirect_to action: "show", id: @user.id
    else
      render 'new'
    end
  end


  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to action: "show", id: @user.id
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
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

  def user_params
    params.require(:user).permit(:email, :admin, :password, :password_confirmation)
  end

end