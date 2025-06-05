class BlogPostsController < ApplicationController
  def index
    @blog_posts = BlogPost.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = Current.user.blog_posts.new(blog_post_params)
    unless @blog_post.save
      redirect_to blog_posts_path, status: :unprocessable_entity, alert: "failed to make blog post"
      # todo: probably make this fallback better
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    @blog_post = BlogPost.find(params[:id])
    if @blog_post.user == Current.user
      @blog_post.destroy
      redirect_to blog_posts_path, notice: "Yay it's deleted"
    else
      redirect_to blog_posts_path, alert: "You're not allowed to do that! Bad!"
    end
  end

  private
  def blog_post_params
    params.expect blog_post: [ :title, :body ]
  end
end
