module Admin
  class MovieRoomsController < BaseController
    before_action :set_movie_room, only: %i[ show update destroy ]

    # GET /admin/movie_rooms
    def index
      @movie_rooms = MovieRoom.all
      render :index, status: :ok
    end

    # GET /admin/movie_rooms/1
    def show
      render :show, status: :ok
    end

    # POST /admin/movie_rooms
    def create
      @movie_room = MovieRoom.new(movie_room_params)

      if @movie_room.save
        render :show, status: :created, location: admin_movie_room_url(@movie_room)
      else
        render json: @movie_room.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/movie_rooms/1
    def update
      if @movie_room.update(movie_room_params)
        render :show, status: :ok
      else
        render json: @movie_room.errors, status: :unprocessable_entity
      end
    end

    # DELETE /admin/movie_rooms/1
    def destroy
      @movie_room.destroy!
    end

    private
      def set_movie_room
        @movie_room = MovieRoom.find(params.require(:id))
      end

      def movie_room_params
        params.require(:movie_room).permit(:number, :total_seats)
      end
  end
end 