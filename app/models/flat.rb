class Flat < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :title, :description, :address, :price_per_day, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_title_and_address,
    against: [ :title, :address ],
    using: {
      tsearch: { prefix: true }
    }
end
