class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    @flats = policy_scope(Flat).order(created_at: :desc)
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
    authorize @flat
  end

  private

  def flat_params
    params.require(:flat).permit(:title, :description, :address, :capacity, :price_per_day, :photo)
  end
end
