# frozen_string_literal: true

class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    notification = current_user.passive_notifications # 自分に対する通知を全取得
    @notifications = notification.other_notification(current_user.id)# 自分の通知は表示させない
    @notifications.where(checked: false).find_each do |notification|
      notification.update!(checked: true) 
    end
  end

  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to request.referer
  end
end
