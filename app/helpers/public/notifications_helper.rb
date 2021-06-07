module Public::NotificationsHelper
 
  def notification_form(notification) 
    @visiter = notification.visiter
    # @chat = nil
    # your_post = link_to 'あなたの投稿', post_path(notification)
    # @visiter_chat = notification.chat_id
    
    case notification.action
      # when "follow" then
      #   tag.a(notification.visiter.first_name, href: user_path(@visiter)) + "があなたをフォローしました。"
       when "like" then
        tag.a(notification.visiter.first_name, href: user_path(@visiter)) + "が" + tag.a('あたなの投稿', href: post_path(notification.post_id)) + "をお気に入りしました。"
      # when "chat" then
      #   @chat = Chat.find_by(id: @visiter_chat)&.talk
      #   tag.a(@visiter.name, href: user_path(@visiter))+ "があなたに新しいチャットを送りました。"
    end
  end
  
  def unchecked_notifications
    @notification = current_user.passive_notifications.where(checked: false)
  end

end
