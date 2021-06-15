# frozen_string_literal: true

class Public::UserRoomsController < ApplicationController
  def destroy
    room = UserRoom.find(params[:id])
    room.destroy!
    redirect_to chats_path, notice: 'チャットルームを削除しました'
  end
end
