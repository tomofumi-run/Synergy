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
    
  end
  
  def search
    
  end
  
  private
  
    def set_current
      @user = current_user
    end
  
    def user_params
      params.require(:user).permit(
        :last_name,:first_name,:hitsory_status,
        :prefecture_code,:work,:profile_image,:introduction)
    end
end
