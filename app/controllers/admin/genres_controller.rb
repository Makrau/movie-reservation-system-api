module Admin
  class GenresController < BaseController
    before_action :set_genre, only: %i[ show update destroy ]

    # GET /admin/genres
    def index
      @genres = Genre.all
      render :index, status: :ok
    end

    # GET /admin/genres/1
    def show
      render :show, status: :ok
    end

    # POST /admin/genres
    def create
      @genre = Genre.new(genre_params)

      if @genre.save
        render :show, status: :created, location: admin_genre_url(@genre)
      else
        render json: @genre.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /admin/genres/1
    def update
      if @genre.update(genre_params)
        render :show, status: :ok
      else
        render json: @genre.errors, status: :unprocessable_entity
      end
    end

    # DELETE /admin/genres/1
    def destroy
      @genre.destroy!
    end

    private
      def set_genre
        @genre = Genre.find(params.require(:id))
      end

      def genre_params
        params.require(:genre).permit(:genre)
      end
  end
end 