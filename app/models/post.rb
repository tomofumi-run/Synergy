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
    return none if content.blank? # contentに記述なしの場合、何も表示させない。

    Post.where('title LIKE?', '%' + content + '%')
  end

  # ---------- お気に入りの通知(post_id,visited_id,actionを格納) ----------

  def create_notification_by(current_user)
    temp = Notification.where(['visiter_id = ? and visited_id = ? and post_id = ? and action = ? ', current_user.id, user_id, id, 'like'])

    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visited_id == notification.visited_id
        notification.checked = true
      end

      notification.save if notification.valid?
    end
  end

  # ---------- コメントの通知(post_id,visited_id,actionを格納) ----------

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全取得、全員に通知を送る distinctは重複レコードを1つにまとめる
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end

    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    if temp_ids.blank?
      save_notification_comment!(current_user, comment_id, user_id)
    end
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することがあるため、1つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )

    # 自分の投稿に対するコメントは通知済み
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end

    notification.save if notification.valid?
  end
end