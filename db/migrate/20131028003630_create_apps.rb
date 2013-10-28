class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name,      limit: 64
      t.string :developer, limit: 64
      t.string :img_url
      t.string :detail_url
      t.string :bundle_id
    end
  end
end
