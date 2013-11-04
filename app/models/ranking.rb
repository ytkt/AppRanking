class Ranking < ActiveRecord::Base

  belongs_to :app
  belongs_to :fetch_date

  scope :top, ->(num) {
    Ranking.includes(:app).where("created_at > ?", Time.now - 1.day).order(:position).limit(num).references(:app)
  }

end
