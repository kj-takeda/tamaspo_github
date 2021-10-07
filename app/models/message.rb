class Message < ApplicationRecord
  belongs_to :current, class_name: "User", optional: true,foreign_key: "current_id"
  belongs_to :partner, class_name: "User", optional: true,foreign_key: "partner_id"

end
