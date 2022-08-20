class Booking < ApplicationRecord
  belongs_to :user, :flat
end
