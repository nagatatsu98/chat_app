class Group < ApplicationRecord
  mount_uploader :image, GroupImageUploader
  mount_uploader :background_image, GroupBackgroundImageUploader
  
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :description, length: { maximum: 6000 }
  validates :token, presence: true, uniqueness: true, length: { minimum: 36 }
  
  has_many :subscribers
  has_many :members, through: :subscribers, source: :user
  
  has_many :messages
    
  def add_subscriber(user)
    self.subscribers.find_or_create_by(user_id: user.id)
  end
  
  def remove_subscriber(user)
    user = self.subscribers.find_by(user_id: user.id)
    user.destroy if user
  end
  
  def subscriber?(user)
    self.members.include?(user)
  end
end
