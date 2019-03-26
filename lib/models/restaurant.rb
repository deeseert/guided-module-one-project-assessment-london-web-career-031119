class Restaurant < ActiveRecord::Base
  has_many :bookings
  has_many :users, through: :bookings

  validates :name, presence: true


  def self.get_all_restaurant
    self.all.map {|restaurant| restaurant.name }
  end

  def self.get_all_names
    self.all.pluck(:name)
  end
end
