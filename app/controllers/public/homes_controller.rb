# frozen_string_literal: true

class Public::HomesController < ApplicationController
  def top
    @posts = Post.includes(:user, :genre).order(created_at: :desc)
  end

  def about; end
end
