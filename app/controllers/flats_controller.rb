class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    if params[:query].present?
      @flats = policy_scope(Flat).search_by_title_and_address(params[:query]).order(created_at: :desc)
      # @flats = Flat.search_by_title_and_address(params[:query])
    else
      @flats = policy_scope(Flat).order(created_at: :desc)
    end
    @markers = @flats.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        info_window: render_to_string(partial: "info_window", locals: { flat: flat })
      }
    end
  end

  def new
    @flat = Flat.new
    authorize @flat
  end

  def create
    @flat = Flat.new(flat_params)
    @flat.user = current_user
    authorize @flat

    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def show
    @flat = Flat.find(params[:id])
    @booking = Booking.new
    @bookings       = @flat.bookings.where(status: 'Accepté').or(@flat.bookings.where(status: 'En cours'))
    @bookings_dates = @bookings.map do |booking|
      {
        from: booking.starting_date,
        to: booking.ending_date
      }
    end
    authorize @flat
  end

  def edit
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def update
    @flat = Flat.find(params[:id])
    @flat.update(flat_params)
    authorize @flat
    if @flat.save
      redirect_to flat_path(@flat)
    else
      render :new
    end
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
    authorize @flat

    redirect_to flats_path
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :description, :address, :capacity, :price_per_day, :photo)
  end
end
