class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #諸々のアソシエーション
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_one_attached :profile_photo

  #フォロー機能
  has_many :follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :follows, source: :followed
  has_many :followers, through: :reverse_of_follows, source: :follower
  # フォローしたときの処理
  def follow(end_user)
    follows.find_or_create_by(followed_id: end_user.id)
  end
  # フォローを外すときの処理
  def unfollow(end_user)
    follows.find_by(followed_id: end_user.id)&.destroy
  end
  # フォローしているか判定
  def following?(end_user)
    followings.include?(end_user)
  end

  def get_profile_photo(width, height)
    unless profile_photo.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_photo.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_photo.variant(resize_to_limit: [width, height]).processed
  end

  # ゲストログイン用
  def self.guest
    find_or_create_by!(end_user_name: 'ゲスト',email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
