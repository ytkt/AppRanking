class App < ActiveRecord::Base

  has_many :rankings


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

  def ranking_last(num)
    return rankings.limit(num).order(created_at: :desc)
  end
end
