class Train < ApplicationRecord
  belongs_to :line  # これを追加
  has_many :places
end
