# -*- coding: utf-8 -*-
class RankingsController < ApplicationController
  def index
    @last_fetched = FetchDate.last_days(7)
    @rankings = @last_fetched.first.rankings

    @categories = @last_fetched.collect { |fd|
      fd.fetched_at.strftime('%m/%d')
    }.reverse

    # グラフ用データ
    @data = {}
    @last_fetched.each_with_index do |fd, i|
      fd.rankings.each do |r|
        bundle_id = r.app.bundle_id
        unless @data.has_key?(bundle_id)
          @data[bundle_id] = {}
          @data[bundle_id]["name"] = r.app.name
          @data[bundle_id]["positions"] = Array.new(i, nil)
        end

        # nilで詰める
        size = @data[bundle_id]["positions"].size
        if size < i
          @data[bundle_id]["positions"] += Array.new(i-size, nil)
        end

        @data[bundle_id]["positions"] << r.position
      end
    end

    @h = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "Week Ranking")
      f.xAxis(:categories => @categories)
      f.yAxis(:max => 70,
              :min => 0,
              :reversed => true,
              :minTickInterval => 1,
              :allowDecimals => false,
              :title => {:text => "rank" })
      @data.each do |key, value|
        f.series(:name => value["name"],
                 :data => value["positions"])
      end
    end
  end
end
