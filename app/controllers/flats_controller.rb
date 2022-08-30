class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    if params[:query].present?
      @flats = policy_scope(Flat).search_by_title_and_address(params[:query]).order(created_at: :desc)
      # @flats = Flat.search_by_title_and_address(params[:query])
    else
      @flats = policy_scope(Flat).order(created_at: :desc)
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
    authorize @flat
  end

  def edit
    @flat = Flat.find(params[:id])
    authorize @flat
  end

  def update
    @flat = Flat.find(params[:id])
    @flat.update_attribute(:photo, params[:flat][:photo])
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
