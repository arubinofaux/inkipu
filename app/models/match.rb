class Match < ApplicationRecord
  belongs_to :player, class_name: "Player", foreign_key: :player_id
  belongs_to :opponent, class_name: "Player", foreign_key: :opponent_id
  belongs_to :winner, class_name: "Player", foreign_key: :winner_id
end

# == Schema Information
#
# Table name: matches
#
#  id            :bigint           not null, primary key
#  done          :boolean          default(FALSE), not null
#  game          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  bnet_match_id :string
#  opponent_id   :bigint
#  player_id     :bigint
#  winner_id     :bigint
#
