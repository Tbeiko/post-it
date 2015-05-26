class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]


  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You've successfully signed up!"
      redirect_to root_path
    else 
      render :new
    end 
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile was updated successfully."
      redirect_to user_path
    else
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :password, :time_zone, :slug)
    end

    def set_user
      @user = User.find_by(slug: params[:id])
    end

    def require_same_user
      if current_user != @user
        flash[:error] = "Oops, you're not supposed to do this."
        redirect_to root_path
      end
    end

end