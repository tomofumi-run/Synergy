class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_current, only: [:show,:edit,:update,:out]
  
  def index
    @users = User.page(params[:page]).per(12)
  end
  
  def show
    
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path, notice:"ユーザー情報を更新しました。"
    else
      render :edit
    end
  end
  
  def quit
  end
  
  def out
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice:"ありがとうございました。またのご利用を心よりお待ちしております。"
  end
  
  def likes
    likes = Like.where(user_id: current_user.id).pluck(:post_id)  # ログイン中のユーザーのお気に入りのpost_idカラムを取得
    @likes_list = Post.find(likes) # postsテーブルから、お気に入り登録済みのレコードを取得
  end
  
  def search
    @content = params[:content]
    @records = User.search_for(@content)
  end
  
  private
  
    def set_current
      @user = User.find(params[:id])
    end
  
    def user_params
      params.require(:user).permit(
        :last_name,:first_name,:history_status,
        :prefecture_code,:work,:profile_image,:introduction)
    end
end
