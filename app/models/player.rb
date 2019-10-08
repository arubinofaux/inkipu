class Player < ApplicationRecord
  belongs_to :user, optional: true
  has_many :player_matches, class_name: "Match", foreign_key: :player_id
  has_many :opponent_matches, class_name: "Match", foreign_key: :opponent_id
  has_many :winner_matches, class_name: "Match", foreign_key: :winner_id

  validates :bnet_name, presence: true

  scope :played_matches, -> (playerId) { Match.where(player_id: playerId).or(Match.where(opponent_id: playerId)) }
end

# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  bnet_name  :string
#  name       :string
#  wins       :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_players_on_bnet_name  (bnet_name) UNIQUE
#
