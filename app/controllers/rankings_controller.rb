class RankingsController < ApplicationController
  def index
    @last_fetched = FetchDate.last
    @rankings = @last_fetched.rankings
  end
end
