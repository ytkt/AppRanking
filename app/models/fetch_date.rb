class FetchDate < ActiveRecord::Base
  has_many :rankings

  scope :last_days, ->(num) {
    includes(:rankings).order("fetched_at DESC").limit(num)
  }

end
