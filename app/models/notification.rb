class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  def self.other_notification(current_user) # クラスメソッド modelクラスのレコード検索など
    Notification.includes([:visiter], [:post]).where.not(visiter_id: current_user) # current_user以外の通知を取得
  end
  
end