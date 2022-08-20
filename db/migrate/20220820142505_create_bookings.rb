class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :status
      t.integer :number_of_occupants
      t.date :starting_date
      t.date :ending_date
      t.float :total_price

      t.timestamps
    end
  end
end
