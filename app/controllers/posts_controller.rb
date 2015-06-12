class PostsController < ApplicationController
  # Set up an instance variable for action (or redirect based on some condition)
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show]
  before_action :require_creator, only: [:edit, :update]


  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse[params[:offset].to_i, Post::PER_PAGE]
    @pages = (Post.all.size / Post::PER_PAGE)
    @pages += 1 if (Post.all.size % Post::PER_PAGE) > 0 
  end

  def show
    @comment = Comment.new
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user 

    if @post.save
      flash[:notice] = "Your post was created."
      verify_if_moderator
      redirect_to posts_path
    else 
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

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|
      format.html do
        if @vote.save
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You've already voted on '#{@post.title}'."
        end
        redirect_to :back
      end

      format.js
    end
  end

   
  private
    def post_params
      params.require(:post).permit(:title, :url, :description, :user_id, category_ids: [])
    end

    def set_post
      @post = Post.find_by(slug: params[:id])
    end 

    def require_creator
      access_denied unless logged_in? and (current_user == @post.creator || current_user.admin?)
    end

end
