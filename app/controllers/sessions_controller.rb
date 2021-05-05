class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username.downcase])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to root_path
    else
      flash.now[:danger] = "Login credentials did not match"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to 'new'
  end
end