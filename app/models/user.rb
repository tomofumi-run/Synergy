class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include JpPrefecture
  jp_prefecture :prefecture_code

  attachment :profile_image
  enum history_status: {
    "経験なし": 0, "1年目": 1, "2年目": 2, "3年目": 3, "4年目": 4,
    "5年目": 5, "6年目": 6, "7年目": 7, "8年目": 8, "9年目": 9,
    "10年目": 10, "11年目": 11, "12年目": 12, "13年目": 13, "14年目": 14,
    "15年目": 15, "16年目": 16, "17年目": 17, "18年目": 18, "19年目": 19,
    "20年目": 20, "21年目": 21, "22年目": 22, "23年目": 23, "24年目": 24, "25年以上": 25,
  }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :prefecture_code, presence: true

  # ---------- フォローとアンフォロー  ----------

  def follow(user_id)
    relationships.create!(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy!
  end

  def following?(user)
    followings.include?(user)
  end

  # ---------- 都道府県入力  ----------

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end

  # ---------- 論理削除者が再ログインできないようにオーバーライド  ----------

  def active_for_authentication?
    super && (is_deleted == false)
  end
  # ---------- last_nameとfirst_nameを絡めた検索  ----------

  def self.search_for(content)
    return none if content.blank?

    f_name = User.where('first_name LIKE ?', '%' + content + '%')
    l_name = User.where('last_name LIKE ?', '%' + content + '%')

    user = f_name + l_name

  end

  def create_notificagtion_follow!(current_user)
    temp = Notification.where(['visiter_id = ? and visited_id = ? and action = ?', current_user.id, id, 'follow'])
    if temp.blank? # tempが空であれば下記を実行

      notification = current_user.active_notifications.new(
        visited_id: id, # 通知を送られたユーザーのid
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def self.guest
    find_or_create_by!(email: 'aaa@aaa.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
      user.last_name = 'ゲスト'
      user.first_name = 'ユーザー'
      user.history_status = 1
      user.prefecture_code =  1
      user.work = '無所属（ゲストユーザーです。）'
      user.introduction = '「SYNERGY」へようこそ。ゲストユーザーでは、ユーザーの編集機能と退会機能、お問合せ機能のご利用を制限させて頂いております。'
      user.profile_image = 'images/guest.png'
    end
  end
end