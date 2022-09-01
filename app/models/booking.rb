class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :flat
  validates :status, :number_of_occupants, :starting_date, :ending_date, :total_price, presence: true

  STATUS = ['Refusé', 'Accepté']
end
