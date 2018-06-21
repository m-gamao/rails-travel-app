class TripsController < ApplicationController
  before_action :require_login

  def index
    set_user
    @trips = @user.trips.all
  end

  def show
    set_user
    @trip = Trip.find(params[:id])
  end

  def new
    current_user
    @trip = @user.trips.build
  end

  def create
    #binding.pry
    # @user = User.find_by(id: session[:user_id])
    current_user
    @trip = Trip.new(trip_params)
    if @trip.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @trip = Trip.find(params[:id])
    if @trip.user != current_user
      flash[:notice] = "You may not edit this trip."
      redirect_to user_trips_path(current_user)
    end
  end

  def update
    set_user
    #@trip = Trip.find(params[:id])
    @trip = @user.trips.find(params[:id])
    @trip.update(trip_params)
    if @trip.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private
  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def trip_params
    params.require(:trip).permit(:user_id, :city_id, :rating, :fave_attraction, :comment, city_attributes:[:city, :country, :country_id])
  end

end
