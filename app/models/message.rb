class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  
  validates :content, length: { maximum: 1000 }
end
