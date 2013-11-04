class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :position
      t.integer :app_id
      t.integer :fetch_date_id

      t.timestamps
    end
  end
end
