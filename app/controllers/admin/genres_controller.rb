class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    
    if @genre.save
      @genres = Genre.all
      redirect_to request.referer, notice: 'ジャンルを追加しました。'
    else
      @genres = Genre.all
      flash.now[:alert] = '項目を入力してください。'
      render :index
    end
  end

  def update
    @genre = Genre.find(params[:id])

    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: '変更内容を保存しました。'
    else
      flash.now[:alert] = '変更内容に不備があります。'
      render 'edit'
    end
  end
  
  def destroy
    genre = Genre.find(params[:id])
    genre.destroy
    redirect_to admin_genres_path
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
