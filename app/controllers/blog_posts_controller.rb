class BlogPostsController < ApplicationController
  def index
    @blog_posts = Current.user.blog_posts.all
  end

  def show
    @blog_post = BlogPost.find(params[:id])
  end

  def new
    @blog_post = BlogPost.new
  end

  def create
    @blog_post = Current.user.blog_posts.new(blog_post_params)
    if @blog_post.save
      redirect_to @blog_post
    else
      puts "something aint right"
      redirect_to blog_posts_path
      # TODO: use render function instead to indicate unprocessable entity
    end
  end

  private
  def blog_post_params
    params.expect blog_post: [ :title, :body ]
  end
end
