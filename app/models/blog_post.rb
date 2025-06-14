class BlogPost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body

  validates :title, presence: true
end
