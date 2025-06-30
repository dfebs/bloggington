class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true

  after_create_commit -> { broadcast_prepend_to "blog_posts", partial: "blog_posts/blog_post", locals: { blog_post: self }, target: "blog_posts" }
end
