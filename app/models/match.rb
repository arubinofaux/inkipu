class Match < ApplicationRecord
  belongs_to :player, class_name: "Player", foreign_key: :player_id
  belongs_to :opponent, class_name: "Player", foreign_key: :opponent_id
  belongs_to :winner, class_name: "Player", foreign_key: :winner_id
end
