class SessionsController < ApplicationController

  def new

  end

  def create
    # ex user.authenticate('password')
    # 1. get user obj
    # 2. see if pw matches (authenticate method)
    # 3. if so, login
    # 4. if not, error message

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
    redirect_to root_path
  end


end