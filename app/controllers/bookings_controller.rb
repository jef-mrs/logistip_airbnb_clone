class BookingsController < ApplicationController
  def create
    @flat = Flat.find(params[:id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    authorize @booking
    if @booking.save!
      redirect_to flats_path
      # A modifier: Renvoyer vers le Dashboard
    else
      redirect_to flat_path(@flat)
    end
  end

  # def update [P3]
  # end
end
