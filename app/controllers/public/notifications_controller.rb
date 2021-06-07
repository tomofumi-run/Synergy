class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @notifications = current_user.passive_notifications
    # binding.pry
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
  
  def destroy_all
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to request.referer
  end
end
