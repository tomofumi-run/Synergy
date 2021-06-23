# frozen_string_literal: true

class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i(edit update likes quit out)
  before_action :out_user, only: [:show]
  before_action :ensure_normal_user, only:  %i(edit update destroy quit out)

  def index
    @users = User.page(params[:page]).per(12).reverse_order
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes([:genre]).reverse_order
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'ユーザー情報を更新しました。'
    else
      flash.now[:alert] = '入力項目に不備があります。'
      render :edit
    end
  end

  def quit; end

  def out
    @user.update!(is_deleted: true)
    reset_session
    redirect_to root_path, notice: 'ありがとうございました。またのご利用を心よりお待ちしております。'
  end

  def likes
    @likes_list = Post.like_posts(current_user.id).reverse
  end

  def search
    @content = params[:content]
    @records = User.search_for(@content)
  end

  private

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user), alert: '権限がありません。' unless @user == current_user
  end

  def out_user
    user = User.find(params[:id])
    unless user.is_deleted == false
      flash.now[:alert] = '退会済みユーザーになります。'
      @users = User.page(params[:page]).per(12).reverse_order
      render :index
    end
  end

  def user_params
    params.require(:user).permit(
      :last_name, :first_name, :history_status,
      :prefecture_code, :work, :profile_image, :introduction
    )
  end
end
