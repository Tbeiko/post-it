class SessionsController < ApplicationController

  def new
  end

  def create

    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Login successful"
      redirect_to root_path
    else
      flash[:error] = "Username or password incorrect, please try again"
      redirect_to login_path
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out successfully"
    redirect_to :back
  end


end