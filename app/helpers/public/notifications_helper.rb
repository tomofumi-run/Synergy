module Public::NotificationsHelper
 
  def notification_form(notification) 
    @visiter = notification.visiter
    
    case notification.action
      when "follow" then
        tag.a(full_name(notification.visiter), href: user_path(@visiter)) + "があなたをフォローしました。"
      when "like" then
        tag.a(full_name(notification.visiter), href: user_path(@visiter)) + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id)) + "をお気に入りしました。"
    end
  end
  
  def unchecked_notifications #未確認通知の発火
    @notification = current_user.passive_notifications.where(checked: false) #checkされていない通知を取得
  end

end
