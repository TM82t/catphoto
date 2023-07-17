class PostComment < ApplicationRecord

  belongs_to :end_user
  belongs_to :post
  has_many :post_comment_notifications, dependent: :destroy
end
