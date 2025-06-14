class CommentsController < ApplicationController
  before_action :verify_user, only: %i[ update edit destroy ]
  def edit
    @comment = Comment.find(params[:id])
    @blog_post = @comment.blog_post
  end

  def update
    @comment = Comment.find(params[:id])
    @blog_post = @comment.blog_post

    unless @comment.update(comment_params)
      redirect_to @blog_post, status: :unprocessable_entity, alert: "Failed to update comment"
      return
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    if @comment.destroy
      redirect_back fallback_location: root_path, notice: "Yay it's deleted"
    else
      redirect_back fallback_location: root_path, alert: "Failed to delete comment"
    end
  end

  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.new(comment_params)
    @comment.user = Current.user

    unless @comment.save
      redirect_to @blog_post, status: :unprocessable_entity, alert: "Failed to make comment"
    return
    end

    respond_to do |format|
      format.turbo_stream

      # Fallback incase javascript is not enabled (i.e. turbo isn't used and html is expected)
      format.html do
        redirect_to @blog_post, notice: "Comment posted"
      end
    end
  end

  def new
    @comment = Comment.new
    @blog_post = BlogPost.find(params[:blog_post_id])
    @parent = params[:parent]
  end

  private
  def comment_params
    params.expect comment: [ :body, :comment_id ]
  end

  def verify_user
    @comment = Comment.find(params[:id])
    if Current.user != @comment.user
      redirect_to root_path, alert: "NO, BAD. You can't edit other user's comments"
    end
  end
end
