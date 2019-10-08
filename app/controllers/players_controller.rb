class PlayersController < ApplicationController
  helper PlayersHelper

  # GET /players
  # GET /players.json
  def index
    @players = Player.all.order(wins: :desc)
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find_by_name(params[:username])
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.fetch(:player, {})
    end
end
