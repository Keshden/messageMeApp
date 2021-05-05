class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_action :require_same_user, only: [:edit, :update, :show, :destroy]
  before_action :require_admin, only: [:index, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have successfully created an account"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "You have successfully updated your account"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show

  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:danger] = "User successfully deleted"
    redirect_to login_path
  end

  def index
    @users = User.all

  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if !logged_in?
      flash[:danger] = "You need to be logged in to view or edit your account"
      redirect_to login_path
    elsif current_user != @user && !current_user.admin?
      flash[:danger] = "You can only view or edit your own account"
      redirect_to root_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "Only admins can perform that action"
      redirect_to root_path
    end
  end

end