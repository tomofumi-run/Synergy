class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy
  validates :talk, presence: true
  
  # def create_notificagtion_chat(current_user,chat_id)
  #   chat_ids = Chat.select(:user_id).where(chat_id: id).where.not(user_id: current_user.id).distinct
  #   chat_ids.each do |chat_id|
  #     save_notification_chat(current_user, chat_id, chat_id['user_id'])
  #   end
  #   save_notification_chat(current_user, chat_id, user_id) if chat_ids.blank?
  # end
  
  # def save_notification_chat(current_user, chat_id, visited_id)
  #   notification = current_user.active_notifications.new(
  #     chat_id: id,
  #     visited_id: visited_id,
  #     action: 'chat'
  #     )
  #   if notification.visiter_id == notification.visited_id
  #     notification.checked = true
  #   end
  #   notification.save if notification.valid?
  # end
end
