class BlogPostsController < ApplicationController
  before_action :set_blog_post, only: %i[show]
  before_action :verify_user, only: %i[edit update destroy]
  def index
    @blog_posts = BlogPost.order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    unless @blog_post.update(blog_post_params)
      redirect_to blog_posts_path, status: :unprocessable_entity, alert: "failed to edit blog post"
      return
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = Current.user.blog_posts.new(blog_post_params)
    unless @blog_post.save
      redirect_to blog_posts_path, status: :unprocessable_entity, alert: "failed to create blog post"
      return
      # todo: probably make this fallback better
    end

    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
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

  def set_blog_post
    @blog_post = BlogPost.find(params[:id])
  end

  def verify_user
    set_blog_post
    if Current.user != @blog_post.user
      redirect_to root_path, alert: "NO, BAD. You can't edit other user's blog posts"
    end
  end
end
