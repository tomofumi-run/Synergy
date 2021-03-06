# frozen_string_literal: true

class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i(create destroy followings followers)

  def create
    current_user.follow(params[:user_id])
    @user.create_notificagtion_follow!(current_user)
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
