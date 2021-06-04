class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post, only: [:show,:destroy]
  
  def index
    @posts = Post.page(params[:page]).per(12)
  end
  
  def show
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, notice:"ユーザーの投稿を削除しました。"
  end
  
  def search
    @content = params[:content]
    @records = Post.search_for(@content)
  end
  
  private
      
    def set_post
      @post = Post.find(params[:id])
    end
    
end