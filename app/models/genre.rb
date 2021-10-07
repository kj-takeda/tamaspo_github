class Genre < ApplicationRecord
  has_many :place_genres
  has_many :places, through: :place_genres

  has_many :users , dependent: :destroy
  has_many :matches , dependent: :destroy
end
