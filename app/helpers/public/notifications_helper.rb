module Public::NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    @chat = nil
    @visiter_comment = notification.comment_id
    @visiter_chat = notification.chat_id

    case notification.action
    when 'follow'
      tag.i(class: 'fas fa-user-friends fa-2x mr-3', style: 'color: #009966;') + tag.a(full_name(notification.visiter), href: user_path(@visiter)) + 'さんが、あなたをフォローしました。'
    when 'like'
      tag.i(class: 'fas fa-star fa-2x mr-3', style: 'color: #FFCC00;') + tag.a(full_name(notification.visiter), href: user_path(@visiter)) + 'さんが、' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'をお気に入りしました。'
    when 'comment' then
      @comment = Comment.find_by(id: @visiter_comment)&.comment
      tag.i(class: 'far fa-comment-alt fa-2x mr-3') + tag.a(full_name(notification.visiter), href: user_path(@visiter)) + 'さんが、' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にコメントしました。'
    when 'chat' then
      @chat = Chat.find_by(id: @visiter_chat)&.talk
      tag.i(class: 'fas fa-comments fa-2x mr-3', style: 'color: #3399FF;') + tag.a(full_name(notification.visiter), href: user_path(@visiter)) + 'さんが、' + tag.a('あなたに新規チャット', href: chat_path(@visiter)) + 'を送信しました。'
    end
  end

  def unchecked_notifications # 未確認通知の発火
    @notification = current_user.passive_notifications.where(checked: false) # checkされていない通知を取得
  end
end
