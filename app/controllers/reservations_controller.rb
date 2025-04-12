class ReservationsController < ApplicationController
  include Authenticable
  before_action :authenticate_request
  before_action :set_showtime, only: [:create]
  before_action :set_reservation, only: [:show, :destroy]

  def index
    @reservations = current_user.reservations
  end

  def show
  end

  def create
    @reservation = @showtime.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      render :show, status: :created
    else
      render json: { errors: @reservation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  private

  def set_showtime
    @showtime = Showtime.find(params[:showtime_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Showtime not found' }, status: :not_found
  end

  def set_reservation
    @reservation = current_user.reservations.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Reservation not found' }, status: :not_found
  end

  def reservation_params
    params.require(:reservation).permit(:seat_number)
  end
end 