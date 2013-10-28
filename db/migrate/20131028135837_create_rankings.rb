class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :position

      t.timestamps
    end
  end
end
