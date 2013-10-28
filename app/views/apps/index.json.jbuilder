json.array!(@apps) do |app|
  json.extract! app, :name, :developer, :img_url, :detail_url
  json.url app_url(app, format: :json)
end
