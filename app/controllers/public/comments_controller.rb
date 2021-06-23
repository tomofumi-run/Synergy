# frozen_string_literal: true

class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_normal_user, only:  %i(create)

  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    comment_post = @comment.post
    render :error unless @comment.save # unlessだった場合 renderさせる後置
    comment_post.create_notification_comment!(current_user, @comment.id)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
