class App < ActiveRecord::Base

  def self.find_by_bundle_id(bundle_id)
    app = where(bundle_id: bundle_id).first

    if app.count > 0
      return app
    else
      return create(bundle_id: bundle_id)
    end
  end


  def set_info(values = {})
    name = values[:name]
    developer = values[:developer]
    img_url = values[:img_url]
    detail_url = values[:detail_url]
  end
end
