 class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_comment, only: :vote

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.creator = current_user


    if @comment.save 
      flash[:notice] = "Your comment was added !"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    
    respond_to do |format|
      format.html do
        if @vote.save
          flash[:notice] = "Your vote was counted."
        else
          flash[:error] = "You've already voted on this comment."
        end
        redirect_to :back
      end

      format.js 
    end
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

end