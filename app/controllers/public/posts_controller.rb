# frozen_string_literal: true

class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :ensure_correct_user, only: %i(edit update destroy)
  impressionist actions: [:show] # PV数を計測

  def index
    @posts = Post.includes(:user, :genre).page(params[:page]).per(12).reverse_order # 最新投稿を表示
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    impressionist(@post, nil, unique: [:session_hash.to_s])
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post), notice: '投稿を更新しました。'
    else
      flash.now[:alert] = '訂正内容に不備があります。'
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
      redirect_to post_path(@post), notice: '投稿が完了しました。'
    else
      flash.now[:alert] = '登録内容に不備があります。'
      render :new
    end
  end

  def destroy
    @post.destroy!
    redirect_to posts_path, notice: '投稿を削除しました。'
  end

  def search
    @content = params[:content]
    @contents = Post.search_for(@content)
    @records = @contents.includes(:user, :genre).page(params[:page]).per(12).reverse_order
  end

  def search_genre
    @content = Genre.find_by(id: params[:genre_id])
    @contents = Post.where(genre_id: @content) 
    @records = Post.includes(:user, :genre).where(genre_id: @content).page(params[:page]).per(12).reverse_order
  end

  private

  def ensure_correct_user
    @post = Post.find(params[:id])
    redirect_to posts_path, alert: '権限がありません。' unless @post.user == current_user
  end

  def post_params
    params.require(:post).permit(:user_id, :genre_id, :post_image, :title, :content)
  end
end