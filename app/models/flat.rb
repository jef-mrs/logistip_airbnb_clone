class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  # CAPACITY = [1..self.capacity]
  validates :title, :description, :address, :price_per_day, presence: true
  # validates :capacity, inclusion: {in: CAPACITY}
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_title_and_address,
    against: [ :title, :address ],
    using: {
      tsearch: { prefix: true }
    }
end
