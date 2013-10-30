class RankingsController < ApplicationController
  def index
    @rankings = Ranking.top(15)

    @data = []
    @rankings.each do |rank|
      @data << rank.app.ranking_last(7).collect { |r| r.position }.reverse
    end
    @categories = @rankings.collect { |r| r.created_at.strftime('%m/%d') }.reverse

    @h = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "Week Ranking")
      f.xAxis(:categories => @categories)
      f.yAxis(:max => @data.max+1,
              :min => 0,
              :reversed => true,
              :minTickInterval => 1,
              :allowDecimals => false,
              :title => {:text => "rank" })
      f.series(:name => "rank",

    end

  end
end
