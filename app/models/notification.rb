class Notification < ApplicationRecord
  #並びを降順に変更
  default_scope -> { order(created_at: :desc) }
  belongs_to :match, optional: true
  belongs_to :comment, optional: true

  #optional: true=nilを許可する
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
