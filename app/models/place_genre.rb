class PlaceGenre < ApplicationRecord
  belongs_to :place
  belongs_to :genre
  validates :genre_id , presence: true
end
