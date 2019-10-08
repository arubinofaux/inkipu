class PlayersController < ApplicationController
  before_action :set_player, only: [:show]
  helper PlayersHelper

  # GET /players
  # GET /players.json
  def index
    @players = Player.all.order(wins: :desc)
  end

  # GET /players/1
  # GET /players/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player
      @player = Player.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def player_params
      params.fetch(:player, {})
    end
end
