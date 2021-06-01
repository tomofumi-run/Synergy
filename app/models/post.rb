class Post < ApplicationRecord
  attachment :post_image
  
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :genre
  
  validates :genre_id, presence: true
  validates :post_image_id, presence: true
  validates :title, presence: true, length: { maximum: 25 }
  validates :content, presence: true
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
