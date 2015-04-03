class PostsController < ApplicationController
  # Set up an instance variable for action (or redirect based on some condition)
  before_action :set_post, only: [:show, :edit, :update]


  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = User.first # Remove this when user authentification is set up

    if @post.save
      flash[:notice] = "Your post was created."
      redirect_to posts_path
    else # Validation error
      render :new
    end
  end

  def edit 
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated successfully."
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :description, :user_id, category_ids: [])
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
