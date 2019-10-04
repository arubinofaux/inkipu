class ApiController < ApplicationController
  protect_from_forgery unless: -> { request.format.json? }

  def pingMatch
    logger.info params["match"]["game"]

    findMatch = Match.where(bnet_match_id: params["match"]["game"])
    if findMatch
    
    else
      Match.new(bnet_match_id: params["match"]["game"]).save
    end

    render json: {}
  end
end
