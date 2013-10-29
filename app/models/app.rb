require 'open-uri'

class App < ActiveRecord::Base

  has_many :rankings

  URL = "https://play.google.com/store/apps/category/COMMUNICATION/collection/topselling_free?hl=jp"
  PROXY = "http://133.242.137.148:80"
  PLAY_URL = "https://play.google.com"

  def self.update_ranking
    res = open(URL, "r", {ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE, proxy: PROXY})
    doc = Nokogiri(res, nil, 'utf-8')

    doc.css('.card.apps.small').each_with_index do |data, index|
      bundle_id = data['data-docid']

      app = find_by_bundle_id(bundle_id)
      app.set_info(data) if app.name.nil?

      app.rankings.create(position: index+1)
    end
  end


  def self.find_by_bundle_id(bundle_id)
    app = where(bundle_id: bundle_id).first

    if app
      return app
    else
      return create(bundle_id: bundle_id)
    end
  end


  def set_info(data)
    self.name       = data.css('.details').css('.title').first['title']
    self.developer  = data.css('.subtitle').first['title']
    self.img_url    = data.css('.cover-image').first['src'].sub(/=w\d*$/, '')
    self.detail_url = data.css('.card-click-target').first['href']

    save
  end

  def play_url
    return PLAY_URL + detail_url
  end
end
