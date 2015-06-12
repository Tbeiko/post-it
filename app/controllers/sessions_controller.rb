class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_to_twilio
        redirect_to pin_path
      else
        login_user(user)
      end
    else
      flash[:error] = "Username or password incorrect, please try again"
      redirect_to login_path
    end

  end

  def pin
    access_denied unless session[:two_factor] == true

    if request.post?
      user = User.find_by pin: params[:pin]

      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user(user)
      else
        flash[:error] = "Sorry, something is wrong with your pin."
        redirect_to pin_path 
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out successfully"
    redirect_to :back
  end

  private

  def login_user(user)
    session[:user_id] = user.id
    flash[:notice] = "Login successful"
    redirect_to root_path
  end

end