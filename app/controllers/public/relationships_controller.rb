class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create,:destroy,:followings,:followers]
  
  def create
    current_user.follow(params[:user_id])
    @user.create_notificagtion_follow!(current_user) #通知を知らせる
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
  end
  
  def followings
    @users = @user.followings.page(params[:page]).reverse_order
  end
  
  def followers
    @users = @user.followers.page(params[:page]).reverse_order
  end
  
  private
  
    def set_user
      @user = User.find(params[:user_id])
    end
end
