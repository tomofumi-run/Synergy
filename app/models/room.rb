class Room < ApplicationRecord
  has_many :user_rooms
  has_many :chats
  has_many :notifications, dependent: :destroy
  
  def create_notification_chat!(current_user,chat_id, another_user_room)
    # 自分以外のコメントしている人を全取得、全員に通知を送る
    temp_ids = Chat.select(:user_id).where(room_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp|
      save_notification_chat!(current_user, chat_id, temp['user_id'])
    end
    
    #誰ともチャットしていない場合、本人に通知を送る
    save_notification_chat!(current_user, chat_id, another_user_room.user_id ) if temp_ids.blank?
  end
  
  def save_notification_chat!(current_user, chat_id, visited_id)
    # 複数回通知をさせる
    notification = current_user.active_notifications.new(
      room_id: id,
      chat_id: chat_id,
      visited_id: visited_id,
      action: 'chat'
      )
    # 自分の投稿に対するコメントは通知済み
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
