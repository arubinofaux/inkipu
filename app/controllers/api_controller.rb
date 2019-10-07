class ApiController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def pingMatch
    logger.info params.inspect
    findMatch = Match.find_by_bnet_match_id(params["match"]["game"])
    if findMatch
      # compare new logs to current match data
    else
      # send to worker
      NewMatchWorker.perform_in(5.seconds, params["match"]["match"]["game"], params["match"]["match"]["spectateKey"], params["game"], params["match"].to_json)
    end

    render json: {}
  end
end
