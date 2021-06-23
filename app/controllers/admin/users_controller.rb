class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, only: %i(show edit update destroy)

  def index
    @users = User.all.page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path, notice: '会員情報を更新しました。'
    else
      flash.now[:alert] = '入力内容に不備があります。'
      render :edit
    end
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path, notice: 'ユーザーを完全に削除しました。'
  end

  def search
    @content = params[:content]
    @records = User.search_for(@content)
  end

  private

  def user_params
    params.require(:user).permit(
      :last_name, :first_name, :hitsory_status,
      :prefecture_code, :work, :profile_image, :introduction, :is_deleted
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
