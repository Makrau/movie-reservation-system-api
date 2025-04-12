module Public
  class ShowtimesController < ApplicationController
    def index
      @showtimes = Showtime.all
      render json: @showtimes, status: :ok
    end

    def show
      @showtime = Showtime.find(params[:id])
      render json: @showtime, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Showtime not found' }, status: :not_found
    end
  end
end 