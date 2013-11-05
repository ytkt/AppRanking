class RankingsController < ApplicationController
  def index
    @last_fetched = FetchDate.last_days(7)
    @rankings = @last_fetched.first.rankings
  end
end
