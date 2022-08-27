class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
  end

  def dashboard
    @flats = Flat.all.where(user: current_user)
    @bookings = Booking.all.where(user: current_user)
    @user = current_user
  end

end
