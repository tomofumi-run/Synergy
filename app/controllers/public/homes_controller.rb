class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.all.order(created_at: :asc)
  end
  
  def about
  end
end
