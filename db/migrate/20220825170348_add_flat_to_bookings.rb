class AddFlatToBookings < ActiveRecord::Migration[6.1]
  def change
    add_reference :bookings, :flat, index: true, foreign_key: true
  end
end
