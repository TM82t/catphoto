class Post < ApplicationRecord

  has_one_attached :image
  belongs_to :end_user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_end_users, through: :favorites, source: :end_user

  validates :name, presence: true
  validates :image, presence: true
  validates :introduction, presence: true

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  #scope :favorite_count, -> { joins(:favorites).group(:id).order('count(favorites.post_id) desc') }
  #scope :comment_count, -> { joins(:post_comments).group(:id).order('count(post_comments.post_id) desc') }
  
  def self.favorite_count
    all_data = self.all
    favorite_data = all_data.joins(:favorites).group(:id).order('count(favorites.post_id) desc')
    unfavorite_data = all_data - favorite_data
    favorite_data + unfavorite_data
  end
  
  def self.comment_count

    all_data = self.all
    comment_data = all_data.joins(:post_comments).group(:id).order('count(post_comments.post_id) desc')
    no_comment_data = all_data - comment_data
    comment_data + no_comment_data
  end


  def get_image
    if image.attached?
      image
    else
      'no.image.jpg'
    end
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'defaule-image.jpg', content_type: 'image/jpg')
    end
    image
  end

  def favorited_by?(end_user)
    favorites.exists?(end_user_id: end_user.id)
  end

end
