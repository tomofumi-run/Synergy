class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :post_id, uniqueness: { scope: :user_id } # 1人が１つの投稿に対して、1つしかお気に入りできない
end