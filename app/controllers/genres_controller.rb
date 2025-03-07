class GenresController < ApplicationController
  before_action :set_movie_genre, only: %i[ show update destroy ]

  # GET /genres
  def index
    @genres = Genre.all

    render json: @genres
  end

  # GET /genres/1
  def show
    render json: @movie_genre
  end

  # POST /genres
  def create
    @movie_genre = Genre.new(movie_genre_params)

    if @movie_genre.save
      render json: @movie_genre, status: :created, location: @movie_genre
    else
      render json: @movie_genre.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /genres/1
  def update
    if @movie_genre.update(movie_genre_params)
      render json: @movie_genre
    else
      render json: @movie_genre.errors, status: :unprocessable_entity
    end
  end

  # DELETE /genres/1
  def destroy
    @movie_genre.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie_genre
      @movie_genre = Genre.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_genre_params
      params.expect(movie_genre: [ :genre ])
    end
end
