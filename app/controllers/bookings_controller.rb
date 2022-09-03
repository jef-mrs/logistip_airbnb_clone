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

def show
  @booking = Booking.find(params[:id])
  @flat = Flat.find(@booking[:flat_id])
  authorize @booking
  authorize @flat
end

def edit
  @booking = Booking.find(params[:id])
  @flat = @booking.flat
  @bookings = @flat.bookings.where(status: 'Accepté')
  @bookings_dates = @bookings.map do |booking|
    {
      from: booking.starting_date,
      to: booking.ending_date
    }
  end
  authorize @booking
end

def update
  @booking = Booking.find(params[:id])
  @booking.update(booking_params)
  @booking.total_price = (@booking.ending_date - @booking.starting_date) * @booking.flat.price_per_day
  authorize @booking
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render :edit
    end
end

def destroy
  @booking = Booking.find(params[:id])
  authorize @booking
  @booking.destroy

  redirect_to dashboard_path
end

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
