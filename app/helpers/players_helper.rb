module PlayersHelper
  def findMatches(playerId)
    Player.played_matches(playerId)
  end

  def playerWins(playerId)
    Player.played_matches(playerId).where.not(winner_id: playerId)
  end
end
