class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    rooms = current_user.user_rooms.pluck(:room_id) #ユーザーに関連するroom_idを配列取得
    @room_lists = UserRoom.includes([:user]).where(room_id: rooms).where.not(user_id: current_user.id) #chat_roomsのデータを取り出す

  end

  def show
    @user = User.find(params[:user_id])
    rooms = current_user.user_rooms.pluck(:room_id) #pluck=特定のカラムの値だけ
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      room = Room.new
      room.save
      UserRoom.create(user_id: @user.id, room_id: room.id)
      UserRoom.create(user_id: current_user.id, room_id: room.id)
    else
      room = user_rooms.room
    end
      @chats = room.chats
      @chat = Chat.new(room_id: room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    
    if @chat.save
      room = @chat.room
      user_room = UserRoom.where(room_id: room.id).where.not(user_id: current_user.id)
      another_user_room = user_room.find_by(room_id: room.id)
      # binding.pry
      room.create_notification_chat!(current_user, @chat.id, another_user_room)
      redirect_to request.referer
    else
      flash[:alert] = "メッセージを入力してください。"
      redirect_to request.referer
    end
    
  end

  private

    def chat_params
      params.require(:chat).permit(:user_id,:room_id,:talk)
    end
end
