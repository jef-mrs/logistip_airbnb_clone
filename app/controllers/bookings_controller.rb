class BookingsController < ApplicationController
  def create
    @flat = Flat.find(params[:flat_id])
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @booking.flat = @flat
    @booking.status = "En cours"
    @booking.total_price = (@booking.ending_date - @booking.starting_date) * @flat.price_per_day
    authorize @booking
    if @booking.save!
      redirect_to dashboard_path
    else
      redirect_to flat_path(@flat)
    end
  end

  # def update [P3]
  # end

  def validate
    @booking = Booking.find(params[:id])
    @booking.update(validate_params)
    authorize @booking
    if @booking.save
      redirect_to dashboard_path
    else
      root_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:number_of_occupants, :starting_date, :ending_date)
  end

  def validate_params
    params.require(:booking).permit(:status)
  end
end
