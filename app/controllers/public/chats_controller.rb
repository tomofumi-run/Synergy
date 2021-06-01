class Public::ChatsController < ApplicationController
  before_action :authenticate_user!,except: [:index]

  def index
    @chats = Chat.where(room_id: current_user.user_room)
    # ここはわからない
  end
  
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id) #pluck
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    
      if user_rooms.nil?
        @room = Room.new
        @room.save
        UserRoom.create(user_id: @user.id, room_id: @room.id)
        UserRoom.create(user_id: current_user.id, room_id: @room.id)
      else
        @room = user_rooms.room
      end
    @chat = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end
  
  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end
  
  private
    
    def chat_params
      params.require(:chat).permit(:room_id,:message)
    end
end
