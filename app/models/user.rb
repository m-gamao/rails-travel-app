class User < ApplicationRecord
  has_many :trips
  has_many :cities, through: :trips
  has_secure_password
  validates :email, presence: true, uniqueness: true

  scope :most_trips, -> { joins(:trips).group('trips.user_id').order("count(trips.user_id) desc").limit(1)}


  def last_trip
    # check this - what happens when you update trip?
    self.trips.last
  end

  def trip_count
    self.trips.count
  end

  def sort_by_rating
    self.trips.all.order("rating DESC")
  end

  def self.sort_by_trip_count
    User.joins(:trips).group('trips.user_id').order("count(trips.user_id) desc")
  end

end
