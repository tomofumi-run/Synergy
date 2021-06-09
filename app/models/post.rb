class Post < ApplicationRecord
  attachment :post_image
  is_impressionable counter_cashe: true

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  belongs_to :user
  belongs_to :genre

  validates :genre_id, presence: true
  validates :post_image, presence: true
  validates :title, presence: true, length: { maximum: 15 }
  validates :content, presence: true, length: { minimum: 30 }

  # ---------- userがlikeをしているかどうか  ----------
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # ---------- postの部分一致  ----------
  def self.search_for(content)
    return none if content.blank? #contentに記述なしの場合、何も表示させない。
    Post.where('title LIKE?', '%' + content + '%')
  end

  # ---------- お気に入りの通知(post_id,visited_id,actionを格納) ----------
  
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "like"
      )
    notification.save if notification.valid?
  end
end