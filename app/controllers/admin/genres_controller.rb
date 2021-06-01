class Admin::GenresController < ApplicationController
  before_action :authenicate_admin!
  
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
      else
        @genres = Genre.all
        render :index
      end
    
  end
  
  def update
    @genre = Genre.find(params[:id])
    
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice:"変更内容を保存しました。"
    else
      render "edit",alert:"変更内容に不備があります。"
    end
  end
  
  private
    
    def genre_params
      params.requre(:genre).permit(:name)
    end
end
