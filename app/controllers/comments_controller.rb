class CommentsController < ApplicationController
  def create
    @blog_post = BlogPost.find(params[:blog_post_id])
    @comment = @blog_post.comments.new(comment_params)
    @comment.user = Current.user

    if @comment.save
      redirect_to @blog_post, notice: "Comment posted!"
    else
      redirect_to @blog_post, alert: "Comment failed to post :("
    end
  end

  private
  def comment_params
    params.expect comment: [ :body, :comment_id ]
  end
end
