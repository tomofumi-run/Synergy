class Public::PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :set_post, only: [:show,:edit,:update,:destroy]
  
  def index
    @posts = Post.page(params[:page]).per(12)
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path,notice:"投稿を更新しました。"
    else
      render :edit
    end
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if @post.save
      redirect_to post_path, notice:"投稿が完了しました。"
    else
      render :new
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, notice:"投稿を削除しました。"
  end
  
  def search
    
  end
  
  private
  
    def set_post
      @post = Post.find(params[:id])
    end
    
    def post_params
      params.require(:post).permit(:user_id,:genre_id,:post_image,:title,:content)
    end
    
end
