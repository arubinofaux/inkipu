class NewMatchWorker
  include Sidekiq::Worker
  sidekiq_options lock: :until_and_while_executing,
                  unique_args: :unique_args

  def perform(matchId, sKey, game, data = {})
    match = JSON.load(data)

    findMatch = Match.find_by_bnet_match_id(matchId)
    if findMatch
    else
      cplayer = nil
      copponent = nil
      winner = nil

      match["players"].each do |p|
        begin
          player = Player.find_or_create_by!(bnet_name: p["name"]) do |player|
            player.name = p["name"].split("#")[0]
            player.bnet_name = p["name"]
          end
        rescue ActiveRecord::RecordNotUnique
          player = Player.find_by_bnet_name(bnet_name: p["name"])
        end

        winner = player.id if p["status"] == "WON"
        cplayer = player.id if p["position"] == "1"
        copponent = player.id if p["position"] == "2"
      end

      Match.create!(
        bnet_match_id: matchId,
        player_id: cplayer,
        opponent_id: copponent,
        winner: winner,
        done: true
      )
    end
  end

  def self.unique_args(args)
    [ args[0], args[1] ]
  end
end