class Group < ApplicationRecord
  mount_uploader :image, GroupImageUploader
  mount_uploader :background_image, GroupBackgroundImageUploader
  
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 6000 }
  validates :token, presence: true, uniqueness: true, length: { minimum: 36 }
end
