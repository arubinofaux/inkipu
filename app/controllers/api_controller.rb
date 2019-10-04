class ApiController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def pingMatch
    # logger.info params #["match"]["game"]

    findMatch = Match.find_by_bnet_match_id_and_done(params["match"]["game"], true)
    if findMatch
      logger.info "found one"
    else
      logger.info "create it"
      
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

      players.each do |player|
        user = User.find_by_bnet_name(player[:name])
        winner = user.id if player[:status] == "WON"
        player = user.id if player[:position] == "1"
        opponent = user.id if player[:position] == "2"
      end

      Match.create!(
        bnet_match_id: params["match"]["game"],
        player_id: player,
        opponent_id: opponent,
        winner: winner,
        done: true
      )
    end

    # logger.info findMatch.inspect

    render json: {}
  end
end
