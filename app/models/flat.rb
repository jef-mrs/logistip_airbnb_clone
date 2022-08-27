class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  # CAPACITY = [1..self.capacity]
  validates :title, :description, :address, :price_per_day, presence: true
  # validates :capacity, inclusion: {in: CAPACITY}
  has_one_attached :photo
end
