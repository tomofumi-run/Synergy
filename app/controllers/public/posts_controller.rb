class Public::PostsController < ApplicationController
  before_action :authenticate_user!,except: [:index]
  before_action :ensure_correct_user, only: [:edit,:update,:destroy]
  
  impressionist :actions => [:show] #PV数を計測
  
  def index
    @posts = Post.page(params[:page]).per(12)
  end
  
  def show
    @post = Post.find(params[:id])
    impressionist(@post)
    @like = Like.new
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post),notice:"投稿を更新しました。"
    else
      flash.now[:alert] = "訂正内容に不備があります。"
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
      redirect_to post_path(@post), notice:"投稿が完了しました。"
    else
      flash.now[:alert] = "登録内容に不備があります。"
      render :new
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path, notice:"投稿を削除しました。"
  end
  
  def search
    @content = params[:content]
    @records = Post.search_for(@content)
  end
  
  private
  
    def ensure_correct_user
      @post = Post.find(params[:id])
      unless @post.user == current_user
        redirect_to posts_path, alert:"権限がありません。"
      end
    end
    
    def post_params
      params.require(:post).permit(:user_id,:genre_id,:post_image,:title,:content)
    end
    
    
    
end
