class Match < ApplicationRecord
  belongs_to :player, class_name: "User", foreign_key: :player_id
  belongs_to :opponent, class_name: "User", foreign_key: :opponent_id
end
