class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  validates :title, :description, :address, :capacity, :price_per_day, presence: true

end
