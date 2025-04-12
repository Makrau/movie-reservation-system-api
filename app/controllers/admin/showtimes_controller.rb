module Admin
  class ShowtimesController < BaseController
    before_action :set_showtime, only: [:show, :update, :destroy]

    def index
      @showtimes = Showtime.all
    end

    def show
    end

    def create
      @showtime = Showtime.new(showtime_params)

      if @showtime.save
        render :show, status: :created
      else
        render json: { errors: @showtime.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @showtime.update(showtime_params)
        render :show, status: :ok
      else
        render json: { errors: @showtime.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @showtime.destroy
      head :no_content
    end

    private

    def set_showtime
      @showtime = Showtime.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Showtime not found' }, status: :not_found
    end

    def showtime_params
      params.require(:showtime).permit(:movie_id, :movie_room_id, :start_time, :end_time)
    end
  end
end 