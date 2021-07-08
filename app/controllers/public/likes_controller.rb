# frozen_string_literal: true

class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    # どの投稿に紐づいたお気に入りなのか
    @post = Post.find(params[:post_id])
    like = @post.likes.new(user_id: current_user.id)
    like.save!
    @post.create_notification_by(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user_id: current_user.id)
    like.destroy!
  end
end
