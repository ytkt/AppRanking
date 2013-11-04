class CreateFetchDates < ActiveRecord::Migration
  def change
    create_table :fetch_dates do |t|
      t.datetime :fetched_at
    end
  end
end
