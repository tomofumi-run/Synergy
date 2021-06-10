module Public::NotificationsHelper
 
  def notification_form(notification) 
    @visiter = notification.visiter
    @comment = nil
    @chat = nil
    @visiter_comment = notification.comment_id
    @visiter_chat = notification.chat_id
    
    case notification.action
      when "follow" then
        tag.a(full_name(notification.visiter), href: user_path(@visiter)) + "があなたをフォローしました。"
      when "like" then
        tag.a(full_name(notification.visiter), href: user_path(@visiter)) + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id)) + "をお気に入りしました。"
      when "comment" then
        @comment = Comment.find_by(id: @visiter_comment)&.comment
        tag.a(full_name(notification.visiter), href: user_path(@visiter)) + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id)) + "にコメントしました。"
      when "chat" then
        @chat = Chat.find_by(id: @visiter_chat)&.talk
        tag.a(full_name(notification.visiter), href: user_path(@visiter)) + "があなたに" + tag.a('新規チャット', href: chat_path(@visiter)) + "を送信しました。"
    end
  end
  
  def unchecked_notifications #未確認通知の発火
    @notification = current_user.passive_notifications.where(checked: false) #checkされていない通知を取得
  end

end
