class FetchDate < ActiveRecord::Base
  has_many :rankings

  scope :last_days, ->(num) {
    includes(:rankings)
      .where("position <= 15")
      .order("fetched_at DESC")
      .limit(num)
      .references(:rankings)
  }

end
