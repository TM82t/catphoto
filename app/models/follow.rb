class Follow < ApplicationRecord
  belongs_to :follower, class_name: "EndUser"
  belongs_to :followed, class_name: "EndUser"

  has_many :follow_notifications, dependent: :destroy

end
