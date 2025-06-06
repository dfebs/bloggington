class CommentsController < ApplicationController
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
end
