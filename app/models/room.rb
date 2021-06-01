class Room < ApplicationRecord
  belongs_to :user_room
  belongs_to :chat
end
