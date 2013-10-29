class RankingsController < ApplicationController
  def index
    @rankings = Ranking.top(15)
  end
end
