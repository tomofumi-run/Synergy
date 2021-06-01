class Public::LikesController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.new(user_id: current_user.id)
    like.save
    redirect_to request.refere
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user_id: current_user.id)
    like.destroy
    redirect_to request.refere
  end
end
