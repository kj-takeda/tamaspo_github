class HideList < ApplicationRecord
  belongs_to :user
  belongs_to :hideuser, class_name: 'User'
  validates :user_id, presence: true
  validates :hideuser_id, presence: true
end
