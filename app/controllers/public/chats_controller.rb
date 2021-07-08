class Public::ChatsController < ApplicationController
  before_action :authenticate_user!

  def index
    rooms = current_user.user_rooms.pluck(:room_id) 
    @room_lists = UserRoom.current_rooms(rooms, current_user)
  end

  def show
    @user = User.find(params[:user_id])
    # current_userのroomを配列として取得
    rooms = current_user.user_rooms.pluck(:room_id)
    # 相手とのroom_idの検索する
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      room = Room.new
      room.save!
      UserRoom.create!(user_id: @user.id, room_id: room.id)
      UserRoom.create!(user_id: current_user.id, room_id: room.id)
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
      # 自分のuser_id以外に紐づいているuser_idとroom_idを取得
      user_room = UserRoom.current_rooms(room, current_user).first
      room.create_notification_chat!(current_user, @chat.id, user_room)
      redirect_to request.referer
    else
      flash[:alert] = 'メッセージを入力してください。'
      redirect_to request.referer
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id, :room_id, :talk)
  end
end
