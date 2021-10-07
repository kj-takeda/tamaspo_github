class Area < ApplicationRecord
  has_many :places , dependent: :destroy
  has_many :matches , dependent: :destroy
end
