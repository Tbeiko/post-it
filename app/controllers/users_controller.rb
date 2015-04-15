class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
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
      redirect_to post_path(@user)
    else
      render :edit
    end
  end

  def show
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

end