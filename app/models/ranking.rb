require 'open-uri'

class Ranking < ActiveRecord::Base

  URL = "https://play.google.com/store/apps/category/COMMUNICATION/collection/topselling_free?hl=jp"
  PROXY = "http://133.242.137.148:80"
  PLAY_URL = "https://play.google.com"

  belongs_to :app
  belongs_to :fetch_date

  scope :top, ->(num) {
    Ranking.includes(:app).where("created_at > ?", Time.now - 1.day).order(:position).limit(num).references(:app)
  }


  def self.update_ranking
    res = nil
    begin
      res = open(URL, "r", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE, proxy: PROXY})
    rescue
      puts "data fetch failed"
      return
    end

    fd = FetchDate.create(fetched_at: Time.now)
    doc = Nokogiri(res, nil, 'utf-8')

    doc.css('.card.apps.small').each_with_index do |data, index|
      bundle_id = data['data-docid']

      app = App.find_by_bundle_id(bundle_id)
      app.set_info(data) if app.name.nil?

      fd.rankings << app.rankings.create(position: index+1)
    end
  end

end
