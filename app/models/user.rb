class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  include JpPrefecture
  jp_prefecture :prefecture_code
  

  attachment :profile_image
  enum history_status: { "経験なし": 0, "1年目": 1, "2年目": 2, "3年目": 3, "4年目": 4,
                         "5年目": 5, "6年目": 6, "7年目": 7, "8年目": 8, "9年目": 9,
                         "10年目": 10, "11年目": 11, "12年目": 12, "13年目": 13, "14年目": 14,
                         "15年目": 15, "16年目": 16, "17年目": 17, "18年目": 18, "19年目": 19,
                         "20年目": 20, "21年目": 21, "22年目": 22, "23年目": 23, "24年目": 24,"25年以上": 25}

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
    
  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end  
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
