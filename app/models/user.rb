class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :blog_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_picture

  validate :valid_image

  def valid_image
    return unless profile_picture.attached?

    if profile_picture.blob.byte_size > 10.megabytes
      errors.add(:profile_picture, "Image must be lower than 10MB")
    end

    acceptable_types = [ "image/jpeg", "image/png" ]

    unless acceptable_types.include?(profile_picture.blob.content_type)
      errors.add(:profile_picture, "Must be JPG or PNG")
    end
  end

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
