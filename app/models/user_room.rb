class UserRoom < ApplicationRecord
  belongs_to :user
  belongs_to :room
  
  def self.current_rooms(room,current_user)
    UserRoom.includes([:user]).where(room_id: room).where.not(user_id: current_user)
  end

end