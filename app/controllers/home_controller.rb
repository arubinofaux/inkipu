class HomeController < ApplicationController
  def index
    @matchesCount = Match.all.count
    @playersCount = Player.all.count
    @userCount = User.all.count
  end
end
