class ApiController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def pingMatch
    findMatch = Match.find_by_bnet_match_id_and_done(params["match"]["game"], true)
    if findMatch
      # compare new logs to current match data
    else
      player = nil
      opponent = nil
      winner = nil

      players = []
      params["players"].each do |p|
        if p["position"] == "1"
          players[0] = {name: p["name"], position: p["position"], status: p["status"]}
        end

        if p["position"] == "2"
          players[1] = {name: p["name"], position: p["position"], status: p["status"]}
        end
      end

      players.each do |p|
        bplayer = Player.find_by_bnet_name(p[:name])
        if bplayer.blank?
          bplayer = Player.create!(name: p[:name].split("#")[0], bnet_name: p[:name])
        end
        winner = bplayer.id if p[:status] == "WON"
        player = bplayer.id if p[:position] == "1"
        opponent = bplayer.id if p[:position] == "2"
      end

      Match.create!(
        bnet_match_id: params["match"]["game"],
        player_id: player,
        opponent_id: opponent,
        winner: winner,
        done: true
      )
    end

    render json: {}
  end
end
