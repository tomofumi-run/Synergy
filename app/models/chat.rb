class Chat < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :user
  belongs_to :room
  validates :talk, presence: true
end
